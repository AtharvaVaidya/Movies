//
//  Operation.swift
//  Movies
//
//  Created by Atharva Vaidya on 14/07/18.
//  Copyright © 2018 Atharva vaidya. All rights reserved.
//

import Foundation

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
    
    public func parser() -> Parser<T>
    {
        return Parser<T>()
    }
}
