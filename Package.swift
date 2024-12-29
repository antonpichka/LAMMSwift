// swift-tools-version:6.0
import PackageDescription

let package = Package(
    name: "LAMMSwift",
    products: [
        .library(
            name: "LAMMSwift",
            targets: [
                "LAMMSwift"
            ]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "LAMMSwift",
            dependencies: [
            ]),
        .testTarget(
            name: "LAMMSwiftTests",
            dependencies: [
                "LAMMSwift"
            ]),
    ]
)
