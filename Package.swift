// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "swift-rng",
  platforms: [
    .iOS(.v13),
    .macOS(.v10_15),
    .watchOS(.v6),
    .tvOS(.v13),
    .driverKit(.v19),
    .macCatalyst(.v13)
  ],
  products: [
    .library(
      name: "RNG",
      targets: ["RNG"]
    ),
  ],
  dependencies: [
  ],
  targets: [
    .target(
      name: "RNG",
      dependencies: []
    ),
    .testTarget(
      name: "RNGTests",
      dependencies: ["RNG"]
    ),
  ]
)
