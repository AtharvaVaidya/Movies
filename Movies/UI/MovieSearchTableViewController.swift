//
//  MovieSearchTableViewController.swift
//  Movies
//
//  Created by Atharva Vaidya on 15/07/18.
//  Copyright © 2018 Atharva vaidya. All rights reserved.
//

import UIKit

class MovieSearchTableViewController: UITableViewController
{
    let presenter: MoviesSearchPresenter
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.tableView.dataSource = presenter
        self.tableView.delegate   = presenter
        
        self.tableView.contentInsetAdjustmentBehavior = .never
    }
    
    init(presenter: MoviesSearchPresenter)
    {
        self.presenter = presenter
        
        super.init(style: .plain)
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        return nil
    }
}
