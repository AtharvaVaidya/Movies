//
//  TableViewModel.swift
//  Movies
//
//  Created by Atharva Vaidya on 13/07/18.
//  Copyright © 2018 Atharva vaidya. All rights reserved.
//

import Foundation

/// A very basic generic struct to adhere to the TableModelProtocol
struct TableModel<T>: TableModelProtocol
{
    typealias Data = T
    
    var data: [T] = []
    
    init(data: [T])
    {
        self.data = data
    }
    
    init() {}
}
