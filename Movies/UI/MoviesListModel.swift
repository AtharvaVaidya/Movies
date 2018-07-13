//
//  TableViewDataProvider.swift
//  Movies
//
//  Created by Atharva Vaidya on 13/07/18.
//  Copyright © 2018 Atharva vaidya. All rights reserved.
//

import UIKit

struct MoviesListModel: TableViewModelProtocol
{
    typealias Data = Movie
    var data: [Data]

    init(movies: [Data])
    {
        self.data = movies
    }
}
