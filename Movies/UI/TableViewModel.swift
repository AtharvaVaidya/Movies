//
//  TableViewModel.swift
//  Movies
//
//  Created by Atharva Vaidya on 13/07/18.
//  Copyright © 2018 Atharva vaidya. All rights reserved.
//

import Foundation

struct TableViewModel<T>: TableViewModelProtocol
{
    typealias Data = T
    
    var data: [T]
    
    init(data: [T])
    {
        self.data = data
    }
}
