//
//  File.swift
//  
//
//  Created by Omarj on 27/02/2023.
//

/* or the old way - > That's a basic example of how a user might use this network module.
 
 let's imagine a user wants to use this network module. Here's an example of how they might use it:
 1. The user starts by creating an instance of Session from Alamofire. This is the main object that will be used for all network requests

 let session = Session()
 
 
 2. The user can then create an instance of NetworkConnectionManager to monitor the network connection status.

 let networkConnectionManager = NetworkConnectionManager()
 
 
 3. The user can create an instance of RequestBuilder to build a URL request. They can set the HTTP method, headers, parameters, and content type if needed.

 let url = URL(string: "https://example.com")! let request = RequestBuilder(baseURL: url) .setMethod(.get) .addHeader("Authorization", value: "Bearer abcdefg") .addParameter("query", value: "test") .setContentType("application/json") .build()
 
 
 4. The user can then use the sendRequest function of NetworkRequest to send the request and handle the response.

 let networkRequest = NetworkRequest(session: session) networkRequest.sendRequest(url: request.url!, completionHandler: { result in switch result { case .success(let data): print("Received data: \(data)") case .failure(let error): print("Error: \(error)") } })
 
 
 5. The user can also create a JSONResponseHandler object to handle JSON responses. They can then use the sendRequest function with the JSONResponseHandler to automatically decode the response to a specified type.

 let jsonResponseHandler = JSONResponseHandler<MyResponse>() networkRequest.sendRequest(url: request.url!, responseHandler: jsonResponseHandler, completionHandler: { result in switch result { case .success(let response): print("Received response: \(response)") case .failure(let error): print("Error: \(error)") } })
 
 6. If the user wants to upload a file, they can use the sendUploadRequest function of NetworkRequest.

 let fileURL = URL(fileURLWithPath: "path/to/file") networkRequest.sendUploadRequest(url: request.url!, responseHandler: jsonResponseHandler, fileURL: fileURL, completionHandler: { result in switch result { case .success(let response): print("Received response: \(response)") case .failure(let error): print("Error: \(error)") } })

 
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

public final class NetworkRequest {
    private let session: Session
    
    public init(session: Session) {
        self.session = session
    }
    
    public func sendRequest(url: URL, completionHandler: @escaping (Result<Data, AFError>) -> Void) {
        // Send the request
        session.request(url).validate().response { response in
            guard let data = response.data else {
                let error = AFError.responseSerializationFailed(reason: .inputDataNilOrZeroLength)
                completionHandler(.failure(error))
                return
            }
            completionHandler(.success(data))
        }
    }
    
    
    //ToDo: No print but use async throws throw ResponseError
    public func sendRequest<T: Decodable, H: ResponseHandler>(url: URL, responseHandler: H, completionHandler: @escaping (Result<T, Error>) -> Void) {
        session.request(url).validate().response { response in
            switch response.result {
            case .success(let data):
                if let data = data {
                    do {
                        let decoded = try responseHandler.handleResponse(data: data) as! T
                        completionHandler(.success(decoded))
                    } catch let error as DecodingError {
                        switch error {
                        case .typeMismatch(let type, let context):
                            print("Type mismatch: \(type) in \(context.debugDescription)")
                        case .valueNotFound(let type, let context):
                            print("Value not found: \(type) in \(context.debugDescription)")
                        case .keyNotFound(let key, let context):
                            print("Key '\(key)' not found: \(context.debugDescription)")
                        case .dataCorrupted(let context):
                            print("Data corrupted: \(context.debugDescription)")
                        @unknown default:
                            print("Unknown error occurred: \(error.localizedDescription)")
                        }
                        completionHandler(.failure(ResponseError.decodingError))//400  status code
                    }
                    catch {
                        completionHandler(.failure(ResponseError.decodingError))//400  status code
                    }
                }else{
                    completionHandler(.failure(ResponseError.emptyDataError))//204 (No Content) status code
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    //This function uses the upload method of the Session to perform the file upload.
    //The multipartFormData closure is used to create the multipart form data for the upload.
    //The to parameter is the URL for the upload.
    //The response handling is the same as the sendRequest function.
    public func sendUploadRequest<T: Decodable, H: ResponseHandler>(url: URL, responseHandler: H, fileURL: URL, completionHandler: @escaping (Result<T, Error>) -> Void) {
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
                        print("Decoding error: \(error)")
                        completionHandler(.failure(ResponseError.decodingError))//400  status code
                    } catch {
                        completionHandler(.failure(ResponseError.decodingError))//400  status code
                    }
                } else {
                    completionHandler(.failure(ResponseError.emptyDataError))//204 (No Content) status code
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }

}
