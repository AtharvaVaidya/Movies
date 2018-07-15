//
//  TableViewDataProviderProtocol.swift
//  Movies
//
//  Created by Atharva Vaidya on 13/07/18.
//  Copyright © 2018 Atharva vaidya. All rights reserved.
//

import Foundation

public protocol TableModelProtocol
{
    associatedtype Data
    
    var data: [Data] { get set }
}