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
        
        self.tableView.dataSource               = presenter
        self.tableView.delegate                 = presenter
        
        self.title                              = presenter.title
        
        self.definesPresentationContext         = true
        self.extendedLayoutIncludesOpaqueBars   = true
        
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
        self.searchController = Factory.ViewControllers.makeSearchController()
        self.tableView.tableHeaderView = self.searchController.searchBar
    }
}
