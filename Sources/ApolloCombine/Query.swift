import Foundation
import Combine
import SwiftUI
import Apollo

@propertyWrapper
public final class Query<Data> {
  
  @EnvironmentObject private var apolloClient: ApolloClient
  private var cancelsPrevious: Bool
  private var cachePolicy: CachePolicy
  private var context: UnsafeMutableRawPointer?
  private var queue: DispatchQueue
  private var apolloCancellable: Apollo.Cancellable?
  
  public init(
    cancelsPrevious: Bool = true,
    cachePolicy: CachePolicy = .returnCacheDataElseFetch,
    context: UnsafeMutableRawPointer? = nil,
    queue: DispatchQueue = DispatchQueue.main
  ) {
    self.cancelsPrevious = cancelsPrevious
    self.cachePolicy = cachePolicy
    self.context = context
    self.queue = queue
  }
  
  @Published
  public private(set) var wrappedValue: Data?
  
  public var projectedValue: QueryState<Data> { state }
  
  @Published
  public private(set) var state: QueryState<Data> = .idle {
    didSet {
      if case .success(let value) = state {
        self.wrappedValue = value
      } else {
        self.wrappedValue = nil
      }
    }
  }

  public func fetch<Query: GraphQLQuery>(
    with query: Query,
    cancelsPrevious: Bool? = nil,
    cachePolicy: CachePolicy? = nil,
    context: UnsafeMutableRawPointer? = nil,
    queue: DispatchQueue? = nil
  ) where Query.Data == Data {
    
    if cancelsPrevious ?? self.cancelsPrevious {
      apolloCancellable?.cancel()
    }
    
    //    self.wrappedValue = .fetching
    
    apolloCancellable = apolloClient.fetch(
      query: query,
      cachePolicy: cachePolicy ?? self.cachePolicy,
      context: context ?? self.context,
      queue: queue ?? self.queue
    ) { [weak self] networkResult in
      guard let self = self else { return }
      let state: QueryState<Query.Data>
      switch networkResult {
      case .success(let graphQLResult):
        let result = graphQLResult.result
        switch result {
        case .success(let data):
          state = .success(data)
        case .failure(let error):
          state = .failure(error)
        }
      case .failure(let error):
        state = .failure(error)
      }
      self.state = state
    }
  }
  
}
