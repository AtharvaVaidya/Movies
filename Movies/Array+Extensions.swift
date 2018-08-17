//
//  Array+Extensions.swift
//  Movies
//
//  Created by Atharva Vaidya on 17/08/2018.
//  Copyright © 2018 Atharva vaidya. All rights reserved.
//

import Foundation

extension Array
{
    /// Returns the element at the specified index iff it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element?
    {
        return indices.contains(index) ? self[index] : nil
    }
}
