// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "StartAppz-Package",
    platforms: [
        .iOS(.v14),
        .macOS(.v11),
        //.watchOS(.v7),
        //.tvOS(.v14)
    ],
    products: [
        //Analytics - This library provides functionalities for tracking and analyzing user behavior, such as events, metrics, and profiles.
        .library(
            name: "Analytics",
            targets: ["Analytics"]
        ),
        //Authentication - This library provides authentication functionalities, such as handling user authentication, authorization, and identity.
        .library(
            name: "Authentication",
            targets: ["Authentication"]
        ),
        //ErrorHandling - This library provides functionalities for handling errors, such as error handling, logging, and recovery.
        .library(
            name: "ErrorHandling",
            targets: ["ErrorHandling"]
        ),
        //ImageAndVideoProcessing - This library provides functionalities for processing images and videos, such as cropping, resizing, and filtering.
        .library(
            name: "ImageAndVideoProcessing",
            targets: ["ImageAndVideoProcessing"]
        ),
        //Localization - This library provides localization functionalities, such as displaying strings, images, and other content in different languages.
        .library(
            name: "Localization",
            targets: ["Localization"]
        ),
        //Logging - This library provides logging functionalities, such as logging messages, events, and errors.
        .library(
            name: "Logging",
            targets: ["Logging"]
        ),
        //MapsAndLocation - This library provides functionalities for displaying and managing maps and locations, such as geocoding, routing, and positioning.
        .library(
            name: "MapsAndLocation",
            targets: ["MapsAndLocation"]
        ),
        //Navigation - This library provides functionalities for navigation, such as navigation controllers, tab bar controllers, and segues.
        .library(
            name: "Navigation",
            targets: ["Navigation"]
        ),
        //Networking - This library provides networking functionalities, such as making HTTP requests, handling responses, and managing network connectivity.
        .library(
            name: "Networking",
            targets: ["Networking"]
        ),
        //Notifications - This library provides functionalities for managing and displaying notifications, such as local and remote notifications.
        .library(
            name: "Notifications",
            targets: ["Notifications"]
        ),
        //Permissions - This library provides functionalities for managing permissions, such as camera, microphone, and photo library access.
        .library(
            name: "Permissions",
            targets: ["Permissions"]
        ),
        //PushNotifications - This library provides functionalities for managing push notifications, such as registering, receiving, and handling notifications.
        .library(
            name: "PushNotifications",
            targets: ["PushNotifications"]
        ),
        //SocialMediaIntegration - This library provides functionalities for integrating with social media, such as sharing, posting, and retrieving data.
        .library(
            name: "SocialMediaIntegration",
            targets: ["SocialMediaIntegration"]
        ),
        //Storage - This library provides storage functionalities, such as managing file system, databases, and key-value stores.
        .library(
            name: "Storage",
            targets: ["Storage"]
        ),
        //Theming - This library provides functionalities for defining and applying themes, such as colors, fonts, and styles.
        .library(
            name: "Theming",
            targets: ["Theming"]
        ),
        //UIComponents - This library provides user interface components, such as buttons, labels, and text fields.
        .library(
            name: "UIComponents",
            targets: ["UIComponents"]
        ),
        //UtilityClasses - This library provides utility classes, such as helper classes, extensions, and general-purpose functions.
        .library(
            name: "UtilityClasses",
            targets: ["UtilityClasses"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", from: "5.4.3"),
        .package(url: "https://github.com/marmelroy/Zip.git", from: "2.1.1"),
    ],
    targets: [
        .target(
            name: "Analytics",
            dependencies: []
        ),
        .target(
            name: "Authentication",
            dependencies: []
        ),
        .target(
            name: "ErrorHandling",
            dependencies: []
        ),
        .target(
            name: "ImageAndVideoProcessing",
            dependencies: []
        ),
        .target(
            name: "Localization",
            dependencies: []
        ),
        .target(
            name: "Logging",
            dependencies: []
        ),
        .target(
            name: "MapsAndLocation",
            dependencies: []
        ),
        .target(
            name: "Navigation",
            dependencies: []
        ),
        .target(
            name: "Networking",
            dependencies: ["Alamofire"]
        ),
        .target(
            name: "Notifications",
            dependencies: []
        ),
        .target(
            name: "Permissions",
            dependencies: []
        ),
        .target(
            name: "PushNotifications",
            dependencies: []
        ),
        .target(
            name: "SocialMediaIntegration",
            dependencies: []
        ),
        .target(
            name: "Storage",
            dependencies: []
        ),
        .target(
            name: "Theming",
            dependencies: []
        ),
        .target(
            name: "UIComponents",
            dependencies: []
        ),
        .target(
            name: "UtilityClasses",
            dependencies: []
        ),
    ]

)
