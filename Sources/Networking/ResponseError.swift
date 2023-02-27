//
//  File.swift
//  
//
//  Created by Omarj on 27/02/2023.
//

import Foundation

public class ResponseError: Error {
    let statusCode: Int
    let data: Data?
    let underlyingError: Error?

    static let decodingError = ResponseError(statusCode: 400, data: nil, underlyingError: nil)
    static let emptyDataError = ResponseError(statusCode: 204, data: nil, underlyingError: nil)

    init(statusCode: Int, data: Data? = nil, underlyingError: Error? = nil) {
        self.statusCode = statusCode
        self.data = data
        self.underlyingError = underlyingError
    }

    public var localizedDescription: String {
        return "Response error: \(statusCode)\nData: \(data != nil ? String(data: data!, encoding: .utf8) ?? "" : "nil")\nUnderlying error: \(underlyingError?.localizedDescription ?? "nil")"
    }
}


