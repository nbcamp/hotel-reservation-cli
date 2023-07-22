// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "hotel-reservation-cli",
    dependencies: [
        .package(url: "https://github.com/stephencelis/SQLite.swift.git", from: "0.14.1"),
//        .package(url: "https://github.com/tristanhimmelman/ObjectMapper.git", .upToNextMajor(from: "4.1.0")),
    ],
    targets: [
        .executableTarget(
            name: "hotel-reservation-cli",
            dependencies: [
                .product(name: "SQLite", package: "SQLite.swift"),
//                .product(name: "ObjectMapper", package: "ObjectMapper")
            ],
            path: "Sources"
        ),
    ]
)
