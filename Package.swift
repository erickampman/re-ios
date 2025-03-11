// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "re-ios",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "re-ios",
            targets: ["re-ios"]
        ),
    ],
    targets: [
        .target(
            name: "re-ios",
            path: "src",
            exclude: ["test", "docs"],
            publicHeadersPath: "include",
            cSettings: [
                .headerSearchPath("include"),
                .define("RE_IOS")
            ],
            linkerSettings: [
                .linkedFramework("Foundation"),
                .linkedFramework("UIKit")
            ]
        ),
        .testTarget(
            name: "re-iosTests",
            dependencies: ["re-ios"],
            path: "test"
        )
    ]
)

