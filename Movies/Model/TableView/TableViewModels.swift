//
//  TableViewModels.swift
//  Movies
//
//  Created by Atharva Vaidya on 13/07/18.
//  Copyright © 2018 Atharva vaidya. All rights reserved.
//

import Foundation
import CoreData

typealias MovieListModel = TableModel<Movie>

/// The model for a SearchQueryPresenter
struct SearchQueryModel: TableModelProtocol
{
    var data: [String] = []
    {
        didSet
        {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
    
    private var key: String = String(describing: SearchQueryModel.self)
    
    //Change this to increase the number of
    private var capacity: Int = 10
    
    init()
    {
        self.data = UserDefaults.standard.array(forKey: key) as? [String] ?? []
    }
    
    mutating func add(query: String)
    {
        if self.data.contains(query) { return }
        
        self.data.insert(query, at: 0)

        if self.data.count > capacity
        {
            self.data = Array(self.data.dropLast(self.data.count - capacity))
        }
    }
}
