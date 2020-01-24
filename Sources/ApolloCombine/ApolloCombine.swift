import SwiftUI
import Combine
import Apollo

extension ApolloClient: ObservableObject { }

public enum QueryState<Data> {
  case idle
  case fetching
  case success(Data)
  case failure(Error)
  
  var isSuccess: Bool { true }
}

extension Array: Error where Element == GraphQLError {
  
}

enum BasicError: Error {
  case reason(String)
}

class ObservableQuery<Query: GraphQLQuery>: ObservableObject {
  let query: Query
  @Published var state: QueryState<Query.Data>
  
  init(query: Query) {
    self.query = query
    self.state = .idle
  }
}

extension GraphQLResult {
  var result: Result<Data, Error> {
    if let data = data {
      return .success(data)
    } else if let errors = errors {
      return .failure(errors)
    } else {
      return .failure(BasicError.reason("No GraphQL data or errors."))
    }
  }
}
// MARK: Apollo + Combine

public struct ApolloPublisher<Query: GraphQLQuery>: Publisher {
  public typealias Output = Query.Data
  public typealias Failure = Error
  
  private let apolloClient: ApolloClient
  private var cachePolicy: CachePolicy = .returnCacheDataElseFetch
  private var context: UnsafeMutableRawPointer? = nil
  private var queue: DispatchQueue = DispatchQueue.main
  private var cancellable: Apollo.Cancellable?
  
  public init(
    client: ApolloClient,
    cachePolicy: CachePolicy = .returnCacheDataElseFetch,
    context: UnsafeMutableRawPointer? = nil,
    queue: DispatchQueue = DispatchQueue.main
  ) {
    self.apolloClient = client
    self.cachePolicy = cachePolicy
    self.context = context
    self.queue = queue
  }
  
  public mutating func query(_ query: Query) {
    cancellable = apolloClient.fetch(query: query, cachePolicy: cachePolicy, context: context, queue: queue) { (result: Result<GraphQLResult<Query.Data>, Error>) in
      Swift.print(result)
    }
  }
  
  public func cancel() {
    cancellable?.cancel()
  }
  
  public func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Output == S.Input {
    fatalError()
  }
  
}
//public protocol Publisher {
//
//  /// The kind of values published by this publisher.
//  associatedtype Output
//
//  /// The kind of errors this publisher might publish.
//  ///
//  /// Use `Never` if this `Publisher` does not publish errors.
//  associatedtype Failure : Error
//
//  /// This function is called to attach the specified `Subscriber` to this `Publisher` by `subscribe(_:)`
//  ///
//  /// - SeeAlso: `subscribe(_:)`
//  /// - Parameters:
//  ///     - subscriber: The subscriber to attach to this `Publisher`.
//  ///                   once attached it can begin to receive values.
//  func receive<S>(subscriber: S) where S : Subscriber, Self.Failure == S.Failure, Self.Output == S.Input
//}

extension ApolloClient {
  
  func publishFetch<Query: GraphQLQuery>(
    query: Query,
    cachePolicy: CachePolicy = .returnCacheDataElseFetch,
    context: UnsafeMutableRawPointer? = nil,
    queue: DispatchQueue = DispatchQueue.main
  ) -> ApolloPublisher<Query.Data> {
    
    ApolloPublisher(client: self, cachePolicy: cachePolicy, context: context, queue: queue)
  }
  
}

// MARK: Apollo + SwiftUI

extension ApolloClient {
  
  @discardableResult
  func fetch<Query: GraphQLQuery>(
    observingQuery observableQuery: ObservableQuery<Query>?,
    cachePolicy: CachePolicy = .returnCacheDataElseFetch,
    context: UnsafeMutableRawPointer? = nil,
    queue: DispatchQueue = DispatchQueue.main
  ) -> Apollo.Cancellable {
    
    return fetch(
      query: observableQuery!.query,
      cachePolicy: cachePolicy,
      context: context,
      queue: queue
    ) { networkResult in
      switch networkResult {
      case .success(let graphQLResult):
        let result = graphQLResult.result
        switch result {
        case .success(let data):
          observableQuery!.state = .success(data)
        case .failure(let error):
          observableQuery!.state = .failure(error)
        }
      case .failure(let error):
        observableQuery!.state = .failure(error)
      }
    }
  }
  
}
