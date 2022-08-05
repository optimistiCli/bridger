// swift-tools-version:5.6

import PackageDescription

let package = Package(
    name: "bridger",
    platforms: [.macOS(.v11)],
    products: [
        .executable(name: "bridger", targets: ["bridger"])
    ],
    dependencies: [
        .package(url: "https://github.com/optimistiCli/iwstb.git", from: "0.1.2"),
//        .package(name: "Iwstb", path: "../Iwstb"),
    ],
    targets: [
        .executableTarget(
            name: "bridger",
            dependencies: [
                .product(
                    name: "Iwstb", 
                    package: "iwstb"
                    ),
//                "Iwstb",
            ],
            path: "Sources"
        ),
    ]
)
