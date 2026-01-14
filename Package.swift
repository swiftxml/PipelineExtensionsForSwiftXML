// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PipelineExtensionsForSwiftXML",
    platforms: [
        .macOS(.v15),
        .iOS(.v17),
        .tvOS(.v17),
        .watchOS(.v10),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "PipelineExtensionsForSwiftXML",
            targets: ["PipelineExtensionsForSwiftXML"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/swiftxml/Pipeline.git", from: "1.0.4"),
        .package(url: "https://github.com/swiftxml/SwiftXML.git", from: "2.0.9"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "PipelineExtensionsForSwiftXML",
            dependencies: [
                "Pipeline",
                "SwiftXML",
            ]
        ),
        .testTarget(
            name: "PipelineExtensionsForSwiftXMLTests",
            dependencies: ["PipelineExtensionsForSwiftXML"]
        ),
    ]
)
