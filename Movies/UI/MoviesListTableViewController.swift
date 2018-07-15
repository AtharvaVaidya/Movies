//
//  MoviesListTableViewController.swift
//  Movies
//
//  Created by Atharva Vaidya on 13/07/18.
//  Copyright © 2018 Atharva vaidya. All rights reserved.
//

import UIKit

class MoviesListTableViewController: UITableViewController
{
    let presenter: MoviesListPresenter
    var searchController: UISearchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.tableView.dataSource   = presenter
        self.tableView.delegate     = presenter
        
        self.title = presenter.title
        
        self.definesPresentationContext = true
        self.extendedLayoutIncludesOpaqueBars = true
        
        addSearchController()
    }
    
    init(presenter: MoviesListPresenter)
    {
        self.presenter = presenter
        
        super.init(style: .plain)
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        return nil
    }
    
    func addSearchController()
    {
        let searchVC = Factory.ViewControllers.makeMovieSearchViewController()
        let searchPresenter = searchVC.presenter
        
        searchController = UISearchController(searchResultsController: searchVC)
        
        searchController.searchResultsUpdater = searchPresenter
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.dimsBackgroundDuringPresentation = true
        searchController.searchBar.sizeToFit()
        
        searchController.searchBar.delegate = searchPresenter
        searchPresenter.searchBar = searchController.searchBar
        
        self.tableView.tableHeaderView = searchController.searchBar
    }
}
