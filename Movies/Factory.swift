//
//  Factory.swift
//  Movies
//
//  Created by Atharva Vaidya on 14/07/18.
//  Copyright © 2018 Atharva vaidya. All rights reserved.
//

import UIKit

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
    
    struct TableViewCells
    {
        static func makeMovieTableViewCell(movie: Movie, in tableView: UITableView) -> MovieTableViewCell
        {
            let cell: MovieTableViewCell
            
            if let tempCell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier) as? MovieTableViewCell
            {
                cell = tempCell
                cell.movie = movie
            }
                
            else
            {
                cell = MovieTableViewCell(movie: movie)
            }
            
            return cell
        }
        
        static func makeSearchQueryCell(query: String, in tableView: UITableView) -> UITableViewCell
        {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "SearchQueryCell")
            {
                cell.textLabel?.text = query
                return cell
            }
                
            else
            {
                let cell = UITableViewCell(style: .default, reuseIdentifier: "SearchQueryCell")
                cell.textLabel?.text = query
                return cell
            }
        }
    }
}
