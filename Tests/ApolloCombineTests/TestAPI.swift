//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// The episodes in the Star Wars trilogy
public enum Episode: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// Star Wars Episode IV: A New Hope, released in 1977.
  case newhope
  /// Star Wars Episode V: The Empire Strikes Back, released in 1980.
  case empire
  /// Star Wars Episode VI: Return of the Jedi, released in 1983.
  case jedi
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)
  
  public init?(rawValue: RawValue) {
    switch rawValue {
    case "NEWHOPE": self = .newhope
    case "EMPIRE": self = .empire
    case "JEDI": self = .jedi
    default: self = .__unknown(rawValue)
    }
  }
  
  public var rawValue: RawValue {
    switch self {
    case .newhope: return "NEWHOPE"
    case .empire: return "EMPIRE"
    case .jedi: return "JEDI"
    case .__unknown(let value): return value
    }
  }
  
  public static func == (lhs: Episode, rhs: Episode) -> Bool {
    switch (lhs, rhs) {
    case (.newhope, .newhope): return true
    case (.empire, .empire): return true
    case (.jedi, .jedi): return true
    case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
    default: return false
    }
  }
  
  public static var allCases: [Episode] {
    return [
      .newhope,
      .empire,
      .jedi,
    ]
  }
}

public final class GetHeroQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition =
  """
    query GetHero($episode: Episode) {
      hero(episode: $episode) {
        __typename
        ...CharacterFragment
      }
    }
    """
  
  public let operationName = "GetHero"
  
  public var queryDocument: String { return operationDefinition.appending(CharacterFragment.fragmentDefinition) }
  
  public var episode: Episode?
  
  public init(episode: Episode? = nil) {
    self.episode = episode
  }
  
  public var variables: GraphQLMap? {
    return ["episode": episode]
  }
  
  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]
    
    public static let selections: [GraphQLSelection] = [
      GraphQLField("hero", arguments: ["episode": GraphQLVariable("episode")], type: .object(Hero.selections)),
    ]
    
    public private(set) var resultMap: ResultMap
    
    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }
    
    public init(hero: Hero? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "hero": hero.flatMap { (value: Hero) -> ResultMap in value.resultMap }])
    }
    
    public var hero: Hero? {
      get {
        return (resultMap["hero"] as? ResultMap).flatMap { Hero(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "hero")
      }
    }
    
    public struct Hero: GraphQLSelectionSet {
      public static let possibleTypes = ["Human", "Droid"]
      
      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLFragmentSpread(CharacterFragment.self),
      ]
      
      public private(set) var resultMap: ResultMap
      
      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }
      
      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }
      
      public var fragments: Fragments {
        get {
          return Fragments(unsafeResultMap: resultMap)
        }
        set {
          resultMap += newValue.resultMap
        }
      }
      
      public struct Fragments {
        public private(set) var resultMap: ResultMap
        
        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }
        
        public var characterFragment: CharacterFragment {
          get {
            return CharacterFragment(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }
      }
    }
  }
}

public struct HumanFragment: GraphQLFragment {
  /// The raw GraphQL definition of this fragment.
  public static let fragmentDefinition =
  """
    fragment HumanFragment on Human {
      __typename
      id
      name
      homePlanet
      height
      mass
      friends {
        __typename
        id
        name
      }
    }
    """
  
  public static let possibleTypes = ["Human"]
  
  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
    GraphQLField("name", type: .nonNull(.scalar(String.self))),
    GraphQLField("homePlanet", type: .scalar(String.self)),
    GraphQLField("height", type: .scalar(Double.self)),
    GraphQLField("mass", type: .scalar(Double.self)),
    GraphQLField("friends", type: .list(.object(Friend.selections))),
  ]
  
  public private(set) var resultMap: ResultMap
  
  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }
  
  public init(id: GraphQLID, name: String, homePlanet: String? = nil, height: Double? = nil, mass: Double? = nil, friends: [Friend?]? = nil) {
    self.init(unsafeResultMap: ["__typename": "Human", "id": id, "name": name, "homePlanet": homePlanet, "height": height, "mass": mass, "friends": friends.flatMap { (value: [Friend?]) -> [ResultMap?] in value.map { (value: Friend?) -> ResultMap? in value.flatMap { (value: Friend) -> ResultMap in value.resultMap } } }])
  }
  
  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }
  
  /// The ID of the human
  public var id: GraphQLID {
    get {
      return resultMap["id"]! as! GraphQLID
    }
    set {
      resultMap.updateValue(newValue, forKey: "id")
    }
  }
  
  /// What this human calls themselves
  public var name: String {
    get {
      return resultMap["name"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "name")
    }
  }
  
  /// The home planet of the human, or null if unknown
  public var homePlanet: String? {
    get {
      return resultMap["homePlanet"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "homePlanet")
    }
  }
  
  /// Height in the preferred unit, default is meters
  public var height: Double? {
    get {
      return resultMap["height"] as? Double
    }
    set {
      resultMap.updateValue(newValue, forKey: "height")
    }
  }
  
  /// Mass in kilograms, or null if unknown
  public var mass: Double? {
    get {
      return resultMap["mass"] as? Double
    }
    set {
      resultMap.updateValue(newValue, forKey: "mass")
    }
  }
  
  /// This human's friends, or an empty list if they have none
  public var friends: [Friend?]? {
    get {
      return (resultMap["friends"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Friend?] in value.map { (value: ResultMap?) -> Friend? in value.flatMap { (value: ResultMap) -> Friend in Friend(unsafeResultMap: value) } } }
    }
    set {
      resultMap.updateValue(newValue.flatMap { (value: [Friend?]) -> [ResultMap?] in value.map { (value: Friend?) -> ResultMap? in value.flatMap { (value: Friend) -> ResultMap in value.resultMap } } }, forKey: "friends")
    }
  }
  
  public struct Friend: GraphQLSelectionSet {
    public static let possibleTypes = ["Human", "Droid"]
    
    public static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
      GraphQLField("name", type: .nonNull(.scalar(String.self))),
    ]
    
    public private(set) var resultMap: ResultMap
    
    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }
    
    public static func makeHuman(id: GraphQLID, name: String) -> Friend {
      return Friend(unsafeResultMap: ["__typename": "Human", "id": id, "name": name])
    }
    
    public static func makeDroid(id: GraphQLID, name: String) -> Friend {
      return Friend(unsafeResultMap: ["__typename": "Droid", "id": id, "name": name])
    }
    
    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }
    
    /// The ID of the character
    public var id: GraphQLID {
      get {
        return resultMap["id"]! as! GraphQLID
      }
      set {
        resultMap.updateValue(newValue, forKey: "id")
      }
    }
    
    /// The name of the character
    public var name: String {
      get {
        return resultMap["name"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "name")
      }
    }
  }
}

public struct CharacterFragment: GraphQLFragment {
  /// The raw GraphQL definition of this fragment.
  public static let fragmentDefinition =
  """
    fragment CharacterFragment on Character {
      __typename
      id
      name
      friends {
        __typename
        id
        name
      }
    }
    """
  
  public static let possibleTypes = ["Human", "Droid"]
  
  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
    GraphQLField("name", type: .nonNull(.scalar(String.self))),
    GraphQLField("friends", type: .list(.object(Friend.selections))),
  ]
  
  public private(set) var resultMap: ResultMap
  
  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }
  
  public static func makeHuman(id: GraphQLID, name: String, friends: [Friend?]? = nil) -> CharacterFragment {
    return CharacterFragment(unsafeResultMap: ["__typename": "Human", "id": id, "name": name, "friends": friends.flatMap { (value: [Friend?]) -> [ResultMap?] in value.map { (value: Friend?) -> ResultMap? in value.flatMap { (value: Friend) -> ResultMap in value.resultMap } } }])
  }
  
  public static func makeDroid(id: GraphQLID, name: String, friends: [Friend?]? = nil) -> CharacterFragment {
    return CharacterFragment(unsafeResultMap: ["__typename": "Droid", "id": id, "name": name, "friends": friends.flatMap { (value: [Friend?]) -> [ResultMap?] in value.map { (value: Friend?) -> ResultMap? in value.flatMap { (value: Friend) -> ResultMap in value.resultMap } } }])
  }
  
  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }
  
  /// The ID of the character
  public var id: GraphQLID {
    get {
      return resultMap["id"]! as! GraphQLID
    }
    set {
      resultMap.updateValue(newValue, forKey: "id")
    }
  }
  
  /// The name of the character
  public var name: String {
    get {
      return resultMap["name"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "name")
    }
  }
  
  /// The friends of the character, or an empty list if they have none
  public var friends: [Friend?]? {
    get {
      return (resultMap["friends"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Friend?] in value.map { (value: ResultMap?) -> Friend? in value.flatMap { (value: ResultMap) -> Friend in Friend(unsafeResultMap: value) } } }
    }
    set {
      resultMap.updateValue(newValue.flatMap { (value: [Friend?]) -> [ResultMap?] in value.map { (value: Friend?) -> ResultMap? in value.flatMap { (value: Friend) -> ResultMap in value.resultMap } } }, forKey: "friends")
    }
  }
  
  public struct Friend: GraphQLSelectionSet {
    public static let possibleTypes = ["Human", "Droid"]
    
    public static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
      GraphQLField("name", type: .nonNull(.scalar(String.self))),
    ]
    
    public private(set) var resultMap: ResultMap
    
    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }
    
    public static func makeHuman(id: GraphQLID, name: String) -> Friend {
      return Friend(unsafeResultMap: ["__typename": "Human", "id": id, "name": name])
    }
    
    public static func makeDroid(id: GraphQLID, name: String) -> Friend {
      return Friend(unsafeResultMap: ["__typename": "Droid", "id": id, "name": name])
    }
    
    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }
    
    /// The ID of the character
    public var id: GraphQLID {
      get {
        return resultMap["id"]! as! GraphQLID
      }
      set {
        resultMap.updateValue(newValue, forKey: "id")
      }
    }
    
    /// The name of the character
    public var name: String {
      get {
        return resultMap["name"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "name")
      }
    }
  }
}
