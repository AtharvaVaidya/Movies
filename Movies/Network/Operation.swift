//
//  Operation.swift
//  Movies
//
//  Created by Atharva Vaidya on 14/07/18.
//  Copyright © 2018 Atharva vaidya. All rights reserved.
//

import Foundation

/// Operation Protocol
protocol OperationProtocol
{
    associatedtype T
    
    /// Request
    var request: RequestProtocol { get set }
    
    func execute(_ success: @escaping (T) -> (), _ failure: @escaping (NetworkError) -> ())
}
