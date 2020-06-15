// swift-tools-version:5.1
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
    dependencies: [
        .package(url: "https://github.com/erica/Swift-General-Utility", from: "0.0.1"),
    ],
    targets: [
        .target(
            name: "CmdlineUtility",
            dependencies: [
                .product(name: "GeneralUtility"),
            ],
            path: "Sources/"
        ),
    ],
    swiftLanguageVersions: [
      .v5
    ]
)
