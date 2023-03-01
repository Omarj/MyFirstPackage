//
//  File.swift
//  
//
//  Created by Omarj on 01/03/2023.
//

import Foundation
import Foundation
import Alamofire

public struct NetworkConfig {
    public let environment: Environment
    public let baseURL: URL
    public let timeoutInterval: TimeInterval
    public let headers: HTTPHeaders?
    
    public init(environment: Environment, baseURL: URL, timeoutInterval: TimeInterval, headers: HTTPHeaders?) {
        self.environment = environment
        self.baseURL = baseURL
        self.timeoutInterval = timeoutInterval
        self.headers = headers
    }
}
