// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "RDSpreadsheet",
    products: [
        .library(
            name: "RDSpreadsheet",
            targets: ["RDSpreadsheet"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "RDSpreadsheet",
            dependencies: []),
        .testTarget(
            name: "RDSpreadsheetTests",
            dependencies: ["RDSpreadsheet"]),
    ]
)
