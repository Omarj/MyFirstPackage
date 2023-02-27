//
//  File.swift
//  
//
//  Created by Omarj on 15/02/2023.
//

import Foundation
import Alamofire

public final class RequestBuilder {
    private let baseURL: URL
    private var method: HTTPMethod = .get
    private var headers: HTTPHeaders = [:]
    private var parameters: Parameters = [:]
    private var contentType: String?
    
    public init(baseURL: URL) {
        self.baseURL = baseURL
    }
    
    public func setMethod(_ method: HTTPMethod) -> RequestBuilder {
        self.method = method
        return self
    }
    
    public func addHeader(_ header: String, value: String) -> RequestBuilder {
        headers[header] = value
        return self
    }
    //    public func addHeader(_ header: String, value: String) -> RequestBuilder {
    //        let builder = RequestBuilder(baseURL: self.baseURL)
    //        builder.method = self.method
    //        builder.headers = self.headers.merging([header: value], uniquingKeysWith: { _, new in new })
    //        builder.parameters = self.parameters
    //        return builder
    //    }
    
    
    public func setContentType(_ contentType: String) -> RequestBuilder {
        self.contentType = contentType
        return self
    }
    
    public func addAuthenticationHeader(token: String) -> RequestBuilder {
        let builder = RequestBuilder(baseURL: self.baseURL)
        builder.method = self.method
        builder.headers = HTTPHeaders(self.headers.dictionary.merging(["Authorization": "Bearer \(token)"]) { _, new in new })
        builder.parameters = self.parameters
        return builder
    }
    
    public func addParameter(_ parameter: String, value: Any) -> RequestBuilder {
        parameters[parameter] = value
        return self
    }
    
    //    public func build() -> URLRequest {
    //        // Build the URL request
    //        let url = URL(string: baseURL.absoluteString)!
    //        var request = URLRequest(url: url)
    //        request.httpMethod = method.rawValue
    //        headers.forEach { request.addValue($0.value, forHTTPHeaderField: $0.name) }
    //        return try! URLEncoding.default.encode(request, with: parameters)
    //    }
    // instead of force unwrapping try and throw
    public func build() throws -> URLRequest {
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)!
        //
        urlComponents.queryItems = parameters.map { key, value in
            URLQueryItem(name: key, value: "\(value)")
        }
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = method.rawValue
        //
        if let contentType = contentType {
            request.addValue(contentType, forHTTPHeaderField: "Content-Type")
        }
        // add headers
        headers.forEach { request.addValue($0.value, forHTTPHeaderField: $0.name) }
        //
        do {
            return try URLEncoding.default.encode(request, with: nil)
        } catch {
            throw error
        }
    }
    
    
}
