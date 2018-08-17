//
//  Operation.swift
//  Movies
//
//  Created by Atharva Vaidya on 14/07/18.
//  Copyright © 2018 Atharva vaidya. All rights reserved.
//

import UIKit

/// Generic Operation object that outlines that basics of an operation
public class NetworkOperation<T>: Operation
{
    var request: RequestProtocol
    let service: Service
    
    var successHandler: ((T) -> ())?
    var failureHandler: ((NetworkError) -> ())?
    
    init(request: RequestProtocol, onSuccess: ((T) -> ())?, onFailure: ((NetworkError) -> ())?)
    {
        self.request = request
        self.service = Service()
        
        self.successHandler = onSuccess
        self.failureHandler = onFailure
    }
    
    init(request: RequestProtocol, serviceConfig: ServiceConfig, onSuccess: ((T) -> ())?, onFailure: ((NetworkError) -> ())?)
    {
        self.request = request
        self.service = Service(serviceConfig)
        
        self.successHandler = onSuccess
        self.failureHandler = onFailure
    }
    
    public override func main()
    {
        if isCancelled { return }
        
        self.execute()
    }
    
    /// Executes the operation
    ///
    /// - Parameters:
    ///   - success: Block with the type associated with the operation.
    ///   - failure: Block in case the operation fails. Provides a NetworkError object.
    func execute()
    {
        DispatchQueue.main.async
        {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
        self.service.execute(request: request,
        { (data) in
            DispatchQueue.main.async
            {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            do
            {
                self.successHandler?(try self.parser().parse(data: data))
            }
            catch
            {
                self.failureHandler?(NetworkError.failedToParseJSONData(data))
            }
        })
        { (error) in
            DispatchQueue.main.async
            {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            self.failureHandler?(error)
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
