// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "HapticClient",
    platforms: [
        .iOS(.v17), .macOS(.v14),
    ],
    products: [
        .singleTargetLibrary("HapticClient"),
        .singleTargetLibrary("HapticClientLive"),
    ],
    dependencies: [
        .package(
            url: "https://github.com/pointfreeco/swift-composable-architecture.git",
            from: "1.25.5"
        ),
    ],
    targets: [
        .target(
            name: "HapticClient",
            dependencies: [
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            ]
        ),
        .target(
            name: "HapticClientLive",
            dependencies: [
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
                "HapticClient",
            ]
        ),
        .testTarget(
            name: "HapticClientTests",
            dependencies: ["HapticClient"]
        ),
    ]
)

extension Product {
    static func singleTargetLibrary(_ name: String) -> Product {
        .library(name: name, targets: [name])
    }
}
