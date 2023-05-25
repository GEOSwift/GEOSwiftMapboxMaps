// swift-tools-version: 5.8
import PackageDescription

let package = Package(
    name: "GEOSwiftMapboxMaps",
    products: [
        .library(
            name: "GEOSwiftMapboxMaps",
            targets: ["GEOSwiftMapboxMaps"]),
    ],
    dependencies: [
        .package(url: "https://github.com/GEOSwift/GEOSwift.git", from: "10.0.0"),
        .package(url: "https://github.com/mapbox/mapbox-maps-ios.git", from: "10.0.0")
    ],
    targets: [
        .target(
            name: "GEOSwiftMapboxMaps",
            dependencies: ["GEOSwift",
                           .product(name: "MapboxMaps", package: "mapbox-maps-ios")
            ]),
        .testTarget(
            name: "GEOSwiftMapboxMapsTests",
            dependencies: ["GEOSwiftMapboxMaps",
                           "GEOSwift",
                           .product(name: "MapboxMaps", package: "mapbox-maps-ios")
            ]),
    ]
)
