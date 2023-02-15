// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "StartAppz-Package",
    platforms: [.iOS(.v15)],
    products: [
        .library(name: "Analytics", targets: ["Analytics"]),
        .library(name: "Networking", targets: ["Networking"]),
        .library(name: "UIComponents", targets: ["UIComponents"])
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire", from: "5.4.0"),
        .package(url: "https://github.com/ReactiveX/RxSwift", from: "6.2.0"),
    ],
    targets: [
        .target(name: "Analytics", dependencies: []),
        .target(name: "Networking", dependencies: ["Alamofire"]),
        .target(name: "UIComponents", dependencies: ["RxSwift"])
    ]
)

