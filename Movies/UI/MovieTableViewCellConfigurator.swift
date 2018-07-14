//
//  MovieTableViewCellDisplayDelegate.swift
//  Movies
//
//  Created by Atharva Vaidya on 14/07/18.
//  Copyright © 2018 Atharva vaidya. All rights reserved.
//

import UIKit

class MovieTableViewCellConfigurator
{
    let movie: Movie
    init(movie: Movie)
    {
        self.movie = movie
    }
    
    func downloadPoster(success: (UIImage) -> (), failure: (NetworkError) -> ())
    {
        
    }
}
