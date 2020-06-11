// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CmdlineUtility",
    platforms: [
      .macOS(.v10_12)
    ],
    products: [
        .library(
            name: "CmdlineUtility",
            targets: ["CmdlineUtility"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "CmdlineUtility",
            dependencies: [],
            path: "Sources/"
            ),
    ],
    swiftLanguageVersions: [
      .v5
    ]
)
