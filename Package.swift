// swift-tools-version:5.4

import PackageDescription

let package = Package(
    name: "VerboseEquatable",
    products: [
        .library(
            name: "VerboseEquatable",
            targets: ["VerboseEquatable"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/jeremyabannister/CollectionToolkit",
            from: "0.1.5"
        ),
        .package(
            url: "https://github.com/jeremyabannister/ProperValueTypes",
            from: "0.1.0"
        ),
        .package(
            url: "https://github.com/jeremyabannister/ExpressionErgonomics",
            from: "0.1.6"
        ),
    ],
    targets: [
        .target(
            name: "VerboseEquatable",
            dependencies: ["ProperValueTypes", "CollectionToolkit"]
        ),
        .testTarget(
            name: "VerboseEquatable-tests",
            dependencies: ["VerboseEquatable"]
        ),
    ]
)
