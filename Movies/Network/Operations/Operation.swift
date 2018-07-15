//
//  Operation.swift
//  Movies
//
//  Created by Atharva Vaidya on 14/07/18.
//  Copyright © 2018 Atharva vaidya. All rights reserved.
//

import Foundation

/// Generic Operation object that outlines that basics of an operation
public class Operation<T>
{
    var request: RequestProtocol
    let service: Service
    
    init(request: RequestProtocol)
    {
        self.request = request
        self.service = Service()
    }
    
    init(request: RequestProtocol, serviceConfig: ServiceConfig)
    {
        self.request = request
        self.service = Service(serviceConfig)
    }
    
    /// Executes the operation
    ///
    /// - Parameters:
    ///   - success: Block with the type associated with the operation.
    ///   - failure: Block in case the operation fails. Provides a NetworkError object.
    func execute(_ success: @escaping (T) -> (), _ failure: @escaping (NetworkError) -> ())
    {
        self.service.execute(request: request,
        { (data) in
            do
            {
                success(try self.parser().parse(data: data))
            }
            catch
            {
                failure(NetworkError.failedToParseJSONData(data))
            }
        })
        { (error) in
            failure(error)
        }
    }
    
    /// The Parser for the current operation
    ///
    /// - Returns: A parser for the type of the current operation.
    public func parser() -> Parser<T>
    {
        return Parser<T>()
    }
}
