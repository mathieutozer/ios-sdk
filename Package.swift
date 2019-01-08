// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "EightBase",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "EightBase",
            targets: ["EightBase"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/apollographql/apollo-ios.git", from: "0.9.4"),
        .package(url: "https://github.com/auth0/Auth0.swift.git", from: "1.14.0"),
        .package(url: "https://github.com/MaxDesiatov/ApolloAlamofire.git", from: "0.2.1")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "EightBase",
            dependencies: ["Auth0", "Apollo", "ApolloAlamofire"]),
        .testTarget(
            name: "EightBaseTests",
            dependencies: ["EightBase"]),
    ]
)
