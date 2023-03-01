//
//  File.swift
//  
//
//  Created by Omarj on 01/03/2023.
//

import Foundation

public struct Config {
    public static var environments: [NetworkConfig] = []
    
    // To add more environments as needed
    public static func addEnvironment(_ environment: NetworkConfig) {
        environments.append(environment)
    }
}

public extension Config {
    static let development = NetworkConfig(
        environment: .development,
        baseURL: URL(string: "https://dev.example.com")!,
        timeoutInterval: 30,
        headers: ["Content-Type": "application/json"]
    )
    
    static let staging = NetworkConfig(
        environment: .staging,
        baseURL: URL(string: "https://staging.example.com")!,
        timeoutInterval: 30,
        headers: ["Content-Type": "application/json"]
    )
    
    static let production = NetworkConfig(
        environment: .production,
        baseURL: URL(string: "https://api.example.com")!,
        timeoutInterval: 60,
        headers: ["Content-Type": "application/json"]
    )
}
