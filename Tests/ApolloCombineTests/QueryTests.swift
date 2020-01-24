import XCTest
import SwiftUI
import Apollo
@testable import ApolloCombine

private struct TestView: View {
  @Query var getHero: QueryState<GetHeroQuery.Data>
  
  private var character: CharacterFragment? { getHero.data?.hero?.fragments.characterFragment }
  
  var body: some View {
    VStack {
      if getHero.isFetching {
        Text("Fetching…")
      } else if getHero.isSuccess {
        Text(character?.name ?? "Unknown name")
      } else if getHero.isError {
        Text(getHero.error!.localizedDescription)
      }
      Button("Fetch hero", action: fetchDefault)
        .disabled(getHero.isSuccess)
      Button("Fetch hero for episode") {
        let episode = try! Episode(jsonValue: "episode 1")
        let query = GetHeroQuery(episode: episode)
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
