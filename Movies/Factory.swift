//
//  Factory.swift
//  Movies
//
//  Created by Atharva Vaidya on 14/07/18.
//  Copyright © 2018 Atharva vaidya. All rights reserved.
//

import Foundation

struct Factory
{
    private init() {}
}

extension Factory
{
    struct ViewControllers
    {
        static func makeMoviesListViewController() -> MoviesListTableViewController
        {
            let presenter = MoviesListPresenter()
            
            let vc = MoviesListTableViewController(presenter: presenter)
            presenter.controller = vc
            
            return vc
        }
        
        static func makeMovieSearchViewController() -> MovieSearchTableViewController
        {
            let presenter = MoviesSearchPresenter()
            
            let vc = MovieSearchTableViewController(presenter: presenter)
            presenter.controller = vc
            
            return vc
        }
    }
}
