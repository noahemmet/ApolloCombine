import XCTest
import SwiftUI
import Apollo
@testable import ApolloCombine

private struct TestView: View {
  @Query var getHero: QueryState<GetHeroQuery.Data>
  
  var body: some View {
    VStack {
      Text(getHero.isSuccess ? "" : "")
      Button("Fetch Episode") {
        let query = GetHeroQuery(episode: try! Episode(jsonValue: "episode 1"))
        self._getHero.fetch(with: query)
      }
    }
    .onAppear(perform: fetchDefault)
  }
  
  private func fetchDefault() {
    let query = GetHeroQuery(episode: try! Episode(jsonValue: "episode 1"))
    _getHero.fetch(with: query)
  }
}

final class QueryTests: XCTestCase {
  
  func testQueryData() {
    
  }
  
  static var allTests = [
    ("testQueryData", testQueryData),
  ]
}
