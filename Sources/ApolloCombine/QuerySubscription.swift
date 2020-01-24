import Combine
import Apollo

final class QuerySubscription<SubscriberType: Subscriber, Query: GraphQLQuery>: Subscription where SubscriberType.Input == Query {
  private var subscriber: SubscriberType?
  private let query: Query
  
  init(subscriber: SubscriberType, query: Query) {
    self.subscriber = subscriber
    self.query = query
//    control.addTarget(self, action: #selector(eventHandler), for: event)
  }
  
  func request(_ demand: Subscribers.Demand) {
    // We do nothing here as we only want to send events when they occur.
    // See, for more info: https://developer.apple.com/documentation/combine/subscribers/demand
  }
  
  func cancel() {
    subscriber = nil
  }
}
