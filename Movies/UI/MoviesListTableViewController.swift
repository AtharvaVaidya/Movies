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
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        guard let configuration = ServiceConfig.appConfig() else { return }
        let movieService = MoviesService(configuration)
        movieService.getMovies({ (movies) in
            print(movies)
        }) { (error) in
            print(error.localizedDescription)
        }
    }
}
