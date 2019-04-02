// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Hermes",
    dependencies: [
        .package(url: "https://github.com/IBM-Swift/Kitura.git", from: "2.5.6"),
        .package(url: "https://github.com/IBM-Swift/Kitura-CORS.git", from: "2.1.0"),
        .package(url: "https://github.com/IBM-Swift/HeliumLogger.git", from: "1.7.1"),
        .package(url: "https://github.com/IBM-Swift/Kitura-Compression.git", from: "2.2.0"),
        .package(url: "https://github.com/IBM-Swift/Swift-Kuery-PostgreSQL", from: "2.1.0"),
        .package(url: "https://github.com/Zyigh/GaiaCodables", from: "0.0.2")
    ],
    targets: [
        .target(
            name: "Hermes",
            dependencies: ["Kitura", "KituraCompression", "HeliumLogger", "KituraCORS", "SwiftKueryPostgreSQL", "GaiaCodables"]),
        .testTarget(
            name: "HermesTests",
            dependencies: ["Hermes"]),
    ]
)
