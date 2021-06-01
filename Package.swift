// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "RDSpreadsheet",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "RDSpreadsheet",
            targets: ["RDSpreadsheet"]),
    ],
    dependencies: [
        .package(
            name: "ExtensionsUIKit",
            url: "git@github.com:drrost/swift-extensions-uikit.git",
            .exact("0.0.4"))
    ],
    targets: [
        .target(
            name: "RDSpreadsheet",
            dependencies: ["ExtensionsUIKit"],
            resources: [.process("Resources")]),
        .testTarget(
            name: "RDSpreadsheetTests",
            dependencies: ["RDSpreadsheet"]),
    ]
)
