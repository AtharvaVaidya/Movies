//
//  TableViewCellFactory.swift
//  Movies
//
//  Created by Atharva Vaidya on 15/07/18.
//  Copyright © 2018 Atharva vaidya. All rights reserved.
//

import UIKit

extension Factory
{
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
