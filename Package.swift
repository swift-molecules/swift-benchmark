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
            url: "https://github.com/swift-atoms/swift-sample.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-numeric.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-cardinal.git",
            branch: "main"
        ),
    ],
    targets: [
        .target(
            name: "Benchmark",
            dependencies: [
                .product(name: "Sample", package: "swift-sample"),
                .product(name: "Numeric", package: "swift-numeric"),
                .product(name: "Cardinal", package: "swift-cardinal"),
            ]
        ),
        .testTarget(
            name: "Benchmark Tests",
            dependencies: [
                .target(name: "Benchmark"),
                .product(name: "Sample", package: "swift-sample"),
                .product(name: "Cardinal", package: "swift-cardinal"),
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    target.swiftSettings =
        (target.swiftSettings ?? []) + [
            .strictMemorySafety(),
            .enableUpcomingFeature("ExistentialAny"),
            .enableUpcomingFeature("InternalImportsByDefault"),
            .enableUpcomingFeature("MemberImportVisibility"),
            .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
            .enableUpcomingFeature("InferIsolatedConformances"),
            .enableExperimentalFeature("Lifetimes"),
            .treatAllWarnings(as: .error),
        ]
}
