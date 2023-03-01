//
//  File.swift
//  
//
//  Created by Omarj on 01/03/2023.
//

import Foundation
import Alamofire

public final class EndpointManager {
    public enum Endpoint: String {
        case login
        case logout
        // add more endpoints
    }
    
    private var endpoints: [Endpoint: EndpointInfo] = [:]
    
    public init() {}
    
    public func addEndpoint(_ endpoint: Endpoint, path: String, method: HTTPMethod, headers: HTTPHeaders? = nil, parameters: Parameters? = nil) {
        endpoints[endpoint] = EndpointInfo(path: path, endPoint_method: method, headers: headers, parameters: parameters)
    }
    
    public func endpointInfo(for endpoint: Endpoint) -> EndpointInfo? {
        return endpoints[endpoint]
    }
    
    public func url(for endpoint: Endpoint, networkConfig: NetworkConfig) -> URL? {
        guard let endpointInfo = endpointInfo(for: endpoint) else {
            return nil
        }
        let fullURL = networkConfig.baseURL.appendingPathComponent(endpointInfo.path)
        return fullURL
    }
}

public struct EndpointInfo {
    public let path: String
    public let endPoint_method: HTTPMethod
    public let headers: HTTPHeaders?
    public let parameters: Parameters?
}



//@dynamicMemberLookup
//public final class EndPointManager {
//    private var endPoints: [String: String] = [:]
//
//    public subscript(dynamicMember path: String) -> String? {
//        get {
//            return endPoints[path]
//        }
//        set {
//            endPoints[path] = newValue
//        }
//    }
//
//    public func addEndPoint(path: String, endPoint: String) {
//        endPoints[path] = endPoint
//    }
//}
//
//let endPointManager = EndPointManager()
//endPointManager.addEndPoint(path: "usersInformation", endPoint: "https://api.example.com/users")
//let usersInformationEndPoint = endPointManager.usersInformation // "https://api.example.com/users"
//
