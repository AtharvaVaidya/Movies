//
//  MoviesListPresenter.swift
//  Movies
//
//  Created by Atharva Vaidya on 14/07/18.
//  Copyright © 2018 Atharva vaidya. All rights reserved.
//

import UIKit

class MoviesListPresenter: NSObject
{
    let model: MovieListModel = MovieListModel()
    weak var delegate: MoviesListTableViewController?
    
    init(delegate: MoviesListTableViewController)
    {
       self.delegate = delegate
    }
}

extension MoviesListPresenter: UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return model.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        guard let movie = model.data[safe: indexPath.row] else { return UITableViewCell() }
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
}

extension MoviesListPresenter: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 200
    }
}
