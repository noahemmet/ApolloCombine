// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "ApolloCombine",
    platforms: [
      .macOS(.v10_13), .iOS(.v13),
  ],
    products: [
        .library(
            name: "ApolloCombine",
            targets: ["ApolloCombine"]),
    ],
    dependencies: [
         .package(url: "https://github.com/apollographql/apollo-ios.git", from: "0.21.0"),
    ],
    targets: [
        .target(
            name: "ApolloCombine",
            dependencies: ["Apollo"]),
        .testTarget(
            name: "ApolloCombineTests",
            dependencies: ["ApolloCombine"]),
    ]
)
