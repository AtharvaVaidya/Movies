//
//  Parser.swift
//  Movies
//
//  Created by Atharva Vaidya on 14/07/18.
//  Copyright © 2018 Atharva vaidya. All rights reserved.
//

import Foundation

public protocol ResponseParser
{
    associatedtype T
    
    func parseJSON(data: Data) throws -> T
}
