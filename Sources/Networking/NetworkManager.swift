//
//  File.swift
//  
//
//  Created by Omarj on 27/02/2023.
//


/* how to use - >  That's a basic example of how a user might use this network module.
 
 let networkManager = NetworkManager()

 // Send a GET request with no parameters
 let url = URL(string: "https://example.com/api/data")!
 networkManager.sendRequest(url: url, responseType: MyResponse.self) { result in
     switch result {
     case .success(let response):
         print("Received response: \(response)")
     case .failure(let error):
         print("Error: \(error)")
     }
 }

 // Upload a file
 let fileURL = URL(fileURLWithPath: "path/to/file")
 networkManager.sendUploadRequest(url: url, fileURL: fileURL, responseType: MyResponse.self) { result in
     switch result {
     case .success(let response):
         print("Received response: \(response)")
    
 let endpointManager = EndpointManager()

 endpointManager.addEndpoint(.login, path: "/login", method: .post, headers: ["Content-Type": "application/json"])

 endpointManager.addEndpoint(.logout, path: "/logout", method: .get)

 if let endpointInfo = endpointManager.endpointInfo(for: .login),
     let url = endpointManager.url(for: .login, baseURL: baseURL) {
     let requestBuilder = RequestBuilder(baseURL: baseURL)
         .set(path: endpointInfo.path)
         .set(method: endpointInfo.method)
         .set(headers: endpointInfo.headers)
         .set(parameters: endpointInfo.parameters)
     // use the requestBuilder to make the request
 }
 */

import Foundation
import Alamofire
import Network

public final class NetworkManager {
    private let session: Session
    
    public init(session: Session) {
        self.session = session
    }
    
    public func sendRequest<T: Decodable, H: ResponseHandler>(request: URLRequest,
                                                              responseType: T.Type,
                                                              responseHandler: H,
                                                              completionHandler: @escaping (Result<T, Error>) -> Void) {
        session.request(request).validate().response { response in
            switch response.result {
            case .success(let data):
                if let data = data {
                    do {
                        let decoded = try responseHandler.handleResponse(data: data) as! T
                        completionHandler(.success(decoded))
                    } catch let error as DecodingError {
                        completionHandler(.failure(ResponseError(statusCode: 400, underlyingError: error)))
                    } catch {
                        completionHandler(.failure(ResponseError(statusCode: 400, underlyingError: error)))
                    }
                } else {
                    completionHandler(.failure(ResponseError.emptyDataError))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }

    
    public func sendRequest<T: Decodable, H: ResponseHandler>(url: URL,
                                                              method: HTTPMethod = .get,
                                                              headers: HTTPHeaders? = nil,
                                                              parameters: Parameters? = nil,
                                                              responseType: T.Type,
                                                              contentType: String? = nil,
                                                              responseHandler: H,
                                                              completionHandler: @escaping (Result<T, Error>) -> Void) {
        var request = URLRequest(url: url)
        //
        request.httpMethod = method.rawValue
        //
        if let headers = headers {
            headers.forEach { header in
                let name = header.name as String
                let value = header.value as String
                request.setValue(value, forHTTPHeaderField: name)
            }
        }
        //
        if let contentType = contentType {
            request.setValue(contentType, forHTTPHeaderField: "Content-Type")
        }
        //
        if let parameters = parameters {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
            } catch {
                completionHandler(.failure(error))
                return
            }
        }
        session.request(request).validate().response { response in
            switch response.result {
            case .success(let data):
                if let data = data {
                    do {
                        let decoded = try responseHandler.handleResponse(data: data) as! T
                        completionHandler(.success(decoded))
                    } catch let error as DecodingError {
                        completionHandler(.failure(ResponseError(statusCode: 400, underlyingError: error)))
                    } catch {
                        completionHandler(.failure(ResponseError(statusCode: 400, underlyingError: error)))
                    }
                } else {
                    completionHandler(.failure(ResponseError.emptyDataError))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    public func sendUploadRequest<T: Decodable, H: ResponseHandler>(url: URL,
                                                                    fileURL: URL,
                                                                    responseType: T.Type,
                                                                    responseHandler: H,
                                                                    completionHandler: @escaping (Result<T, Error>) -> Void) {
        session.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(fileURL, withName: "file")
        }, to: url).validate().response { response in
            switch response.result {
            case .success(let data):
                if let data = data {
                    do {
                        let decoded = try responseHandler.handleResponse(data: data) as! T
                        completionHandler(.success(decoded))
                    } catch let error as DecodingError {
                        completionHandler(.failure(ResponseError(statusCode: 400, underlyingError: error)))
                    } catch {
                        completionHandler(.failure(ResponseError(statusCode: 400, underlyingError: error)))
                    }
                } else {
                    completionHandler(.failure(ResponseError.emptyDataError))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
