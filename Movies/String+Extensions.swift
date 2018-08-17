//
//  String+Extensions.swift
//  Movies
//
//  Created by Atharva Vaidya on 17/08/2018.
//  Copyright © 2018 Atharva vaidya. All rights reserved.
//

import Foundation

public extension String
{
    /// Fill up a string by replacing values in specified placeholders
    ///
    /// - Parameter dict: dict to use
    /// - Returns: replaced string
    public func fill(withValues dict: [String: Any?]?) -> String {
        guard let data = dict else {
            return self
        }
        var finalString = self
        data.forEach { arg in
            if let unwrappedValue = arg.value {
                finalString = finalString.replacingOccurrences(of: "{\(arg.key)}", with: String(describing: unwrappedValue))
            }
        }
        return finalString
    }
    
    public func stringByAdding(urlEncodedFields fields: ParamsDict?) throws -> String
    {
        guard let f = fields else { return self }
        return try f.urlEncodedString(base: self)
    }
}
