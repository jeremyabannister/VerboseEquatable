// swift-tools-version:5.4

import PackageDescription

let package = Package(
    name: "VerboseEquatable",
    products: [
        .library(
            name: "VerboseEquatable",
            targets: ["VerboseEquatable"]
        ),
        .library(
            name: "VerboseEquatableTestToolkit",
            targets: ["VerboseEquatableTestToolkit"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/jeremyabannister/CollectionToolkit",
            from: "0.1.5"
        ),
        .package(
            url: "https://github.com/jeremyabannister/ProperValueType",
            from: "0.1.0"
        ),
        .package(
            url: "https://github.com/jeremyabannister/Testable",
            from: "0.1.0"
        ),
        .package(
            url: "https://github.com/jeremyabannister/SingleTypeTestCase",
            from: "0.1.0"
        ),
    ],
    targets: [
        .target(
            name: "VerboseEquatable",
            dependencies: [
                "ProperValueType",
                "CollectionToolkit",
                "Testable"
            ]
        ),
        .target(
            name: "VerboseEquatableTestToolkit",
            dependencies: [
                "VerboseEquatable",
                "ProperValueType",
                "CollectionToolkit",
                "Testable"
            ]
        ),
        .testTarget(
            name: "VerboseEquatable-tests",
            dependencies: ["VerboseEquatableTestToolkit"]
        ),
        .testTarget(
            name: "VerboseEquatableTestToolkit-tests",
            dependencies: ["VerboseEquatableTestToolkit"]
        ),
    ]
)
