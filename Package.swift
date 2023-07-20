// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "hotel-reservation-cli",
    targets: [
        .executableTarget(
            name: "hotel-reservation-cli",
            path: "Sources"),
    ]
)
