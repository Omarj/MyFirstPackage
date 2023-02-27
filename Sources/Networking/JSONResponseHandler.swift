//
//  File 3.swift
//  
//
//  Created by Omarj on 27/02/2023.
//

import Foundation
import Network
import Alamofire


public protocol ResponseHandler: Decodable {
    associatedtype ResponseType
    
    func handleResponse(data: Data) throws -> ResponseType
}


public class JSONResponseHandler<T: Decodable>: ResponseHandler {
    public func handleResponse(data: Data) throws -> T {
        // Create JSON decoder
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase //keyDecodingStrategy
        decoder.dateDecodingStrategy = .iso8601 // or any other desired format
        // Decode data
        do {
            let decoded = try decoder.decode(T.self, from: data)
            return decoded
        } catch let error as DecodingError {
            throw ResponseError(statusCode: 400, data: nil, underlyingError: error)
        } catch {
            throw ResponseError(statusCode: 400, data: nil, underlyingError: error)
        }
    }
}
