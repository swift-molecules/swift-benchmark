// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "swift-benchmark",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [
        .library(name: "Benchmark", targets: ["Benchmark"])
    ],
    dependencies: [
        .package(
            url: "https://github.com/swift-primitives/swift-sample-primitives.git",
            branch: "testing-stack/sample-sendable-metatype"
        ),
        .package(
            url: "https://github.com/swift-primitives/swift-numeric-primitives.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-primitives/swift-cardinal-primitives.git",
            branch: "main"
        ),
    ],
    targets: [
        .target(
            name: "Benchmark",
            dependencies: [
                .product(name: "Sample Primitives", package: "swift-sample-primitives"),
                .product(name: "Real Primitives", package: "swift-numeric-primitives"),
                .product(name: "Cardinal Primitives", package: "swift-cardinal-primitives"),
            ]
        ),
        .testTarget(
            name: "Benchmark Tests",
            dependencies: [
                .target(name: "Benchmark"),
                .product(name: "Sample Primitives", package: "swift-sample-primitives"),
                .product(name: "Cardinal Primitives", package: "swift-cardinal-primitives"),
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("LifetimeDependence"),
        .enableExperimentalFeature("Lifetimes"),
        .enableExperimentalFeature("SuppressedAssociatedTypes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
        .enableUpcomingFeature("LifetimeDependence"),
    ]
    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem
}
