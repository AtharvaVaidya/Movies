//
//  APIResponse.swift
//  Movies
//
//  Created by Atharva Vaidya on 14/07/18.
//  Copyright © 2018 Atharva vaidya. All rights reserved.
//

import Foundation

public struct Response: ResponseProtocol
{
    public let httpResponse: HTTPURLResponse?
    public let data: Data?
    let error: NSError?
    
    /// Type of result
    public let type: Response.Result
    
    /// Status code of the response
    public var httpStatusCode: Int?
    {
        return self.type.code
    }

    /// Request executed
    public let request: RequestProtocol
    
    /// Type of response
    ///
    /// - success: success
    /// - error: error
    public enum Result
    {
        case success(_: Int)
        case error(_: Int)
        case noResponse
        
        private static let successCodes: Range<Int> = 200..<299
        
        public static func from(response: URLResponse?) -> Result
        {
            guard let r = response as? HTTPURLResponse
            else
            {
                return .noResponse
            }
            return (Result.successCodes.contains(r.statusCode) ? .success(r.statusCode) : .error(r.statusCode))
        }
        
        public var code: Int?
        {
            switch self
            {
                case .success(let code):     return code
                case .error(let code):       return code
                case .noResponse:            return nil
            }
        }
    }
    
    init(response: URLResponse?, data: Data?, error: NSError?, request: RequestProtocol)
    {
        self.httpResponse = response as? HTTPURLResponse
        self.data = data
        self.error = error
        self.type = Result.from(response: response)
        self.request = request
    }
    
    public func toJSON() -> NSDictionary
    {
        return NSDictionary()
    }
    
    public func toString(_ encoding: String.Encoding?) -> String?
    {
        return nil
    }
}
