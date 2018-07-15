//
//  ViewControllerFactory.swift
//  Movies
//
//  Created by Atharva Vaidya on 15/07/18.
//  Copyright © 2018 Atharva vaidya. All rights reserved.
//

import UIKit

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
        
        static func makeSearchController() -> UISearchController
        {
            let searchVC = makeMovieSearchViewController()
            let searchPresenter = searchVC.presenter
            
            let searchController = UISearchController(searchResultsController: searchVC)
            
            searchController.searchResultsUpdater = searchPresenter
            searchController.hidesNavigationBarDuringPresentation = true
            searchController.dimsBackgroundDuringPresentation = true
            searchController.searchBar.sizeToFit()
            
            searchController.searchBar.delegate = searchPresenter
            searchPresenter.searchBar = searchController.searchBar
            
            return searchController
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
