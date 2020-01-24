import Combine
import Apollo


struct QueryPublisher<Query: GraphQLQuery>: Publisher {
  
  typealias Output = Query.Data
  typealias Failure = Error
  
  let query: Query

  init(query: Query) {
    self.query = query
  }
  
  func receive<S>(subscriber: S) where S: Subscriber, S.Failure == QueryPublisher.Failure, S.Input == QueryPublisher.Output {
//    let subscription = QuerySubscription<S, Query>(subscriber: subscriber, query: query)
//    subscriber.receive(subscription: subscription)
  }
}
