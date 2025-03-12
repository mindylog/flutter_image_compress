// swift-tools-version:5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "flutter_image_compress_common",
    platforms: [
        .iOS("12.0")
    ],
    products: [
        .library(
            name: "flutter_image_compress_common",
            targets: ["flutter_image_compress_common"]),
    ],
    dependencies: [
        .package(url: "https://github.com/SDWebImage/SDWebImage.git", from: "5.1.0"),
        .package(url: "https://github.com/SDWebImage/SDWebImageWebPCoder.git", from: "0.6.1"),
        .package(url: "https://github.com/Mantle/Mantle.git", from: "2.1.0"),
        .package(name: "SYPictureMetadata", url: "https://github.com/dvkch/SYPictureMetadata.git", from: "1.4.0")
    ],
    targets: [
        .target(
            name: "flutter_image_compress_common",
            dependencies: [
                "SDWebImage",
                "SDWebImageWebPCoder",
                "Mantle",
                "SYPictureMetadata"
            ],
            path: "Sources/flutter_image_compress_common",
            sources: ["*.swift"]
        )
    ],
    swiftLanguageVersions: [.v5]
)
