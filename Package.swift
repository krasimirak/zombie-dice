// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ZombieDiceGame",
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
        name: "Helpers",
        dependencies: []),
        .target(
            name: "ZombieDiceGame",
            dependencies: ["Die", "Player", "Game"]),
        .target (
            name: "Die",
            dependencies: []),
        .target (
            name: "Person",
            dependencies: []),
        .target (
            name: "Player",
            dependencies: ["Person"]),
        .target (
            name: "Result",
            dependencies: []),
        .target (
            name: "Turn",
            dependencies: ["Die", "Result", "Helpers"]),
        .target (
            name: "Game",
            dependencies: ["Die", "Player", "Turn", "Result", "Helpers"]),
        .testTarget(
            name: "ZombieDiceGameTests",
            dependencies: ["ZombieDiceGame"]),
    ]
)

