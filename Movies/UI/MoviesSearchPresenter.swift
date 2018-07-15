//
//  MoviesSearchPresenter.swift
//  Movies
//
//  Created by Atharva Vaidya on 15/07/18.
//  Copyright © 2018 Atharva vaidya. All rights reserved.
//

import UIKit
import CoreData

class MoviesSearchPresenter: NSObject
{
    var model:              MovieListModel   = MovieListModel()
    var searchQueriesModel: SearchQueryModel = SearchQueryModel()

    public weak var controller: MovieSearchTableViewController?
    public weak var searchBar: UISearchBar?
    
    private let imageCache: NSCache<NSString, UIImage> =
    {
        let cache = NSCache<NSString, UIImage>()
        cache.name = "Posters Cache"
        return cache
    }()
        
    let queue: OperationQueue = OperationQueue()
    
    var searching: Bool = false
    {
        didSet
        {
            self.controller?.tableView.reloadData()
        }
    }
    
    override init()
    {
        super.init()
        
        self.controller?.tableView.delegate = self
        self.controller?.tableView.dataSource = self
        self.controller?.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SearchQueryCell")
    }
    
    func search(title: String)
    {
        queue.addOperation
        {
            SearchMovies(title: title).execute({ (movies) in
                print("Search results for \(title): \(movies)")
                self.updateModelAndUI(with: movies)
            })
            { (error) in
                print("Error retrieving search results for \(title)")
                print(error.localizedDescription)
            }
        }
    }
    
    func updateModelAndUI(with movies: [Movie])
    {
        DispatchQueue.main.async
        {
            let startingIndex = self.model.data.count - movies.count
            let indicesArr = Array(startingIndex..<self.model.data.count)
            let indices = indicesArr.map({ IndexPath(row: $0, section: 0) })
            
            self.model.data.append(contentsOf: movies)
            
            self.controller?.tableView.beginUpdates()
            self.controller?.tableView.insertRows(at: indices, with: .automatic)
            self.controller?.tableView.endUpdates()
        }
    }
}

extension MoviesSearchPresenter: UISearchBarDelegate
{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        guard let searchText = searchBar.text, !searchText.isEmpty else { return }
    
        searchQueriesModel.add(query: searchText)
    }
}

extension MoviesSearchPresenter: UISearchResultsUpdating
{
    func updateSearchResults(for searchController: UISearchController)
    {
        searchController.searchResultsController?.view.isHidden = false
        guard let searchText = searchController.searchBar.text, !searchText.isEmpty
        else
        {
            searching = false
            return
        }
        
        searching = true
        
        self.model.data = []
        self.controller?.tableView.reloadData()
        
        queue.cancelAllOperations()
        
        search(title: searchText)
    }
}

extension MoviesSearchPresenter: UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        print("Count: \(searching ? model.data.count : searchQueriesModel.data.count)")
        return searching ? model.data.count : searchQueriesModel.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if !searching
        {
            guard let query = searchQueriesModel.data[safe: indexPath.row] else { return UITableViewCell() }
            
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
        
        if let cachedImage = imageCache.object(forKey: movie.posterPath as NSString)
        {
            cell.update(image: cachedImage)
        }
            
        else
        {
            GetPoster(movie: movie).execute(
                { (image) in
                    DispatchQueue.main.async
                        {
                            self.imageCache.setObject(image, forKey: movie.posterPath as NSString)
                            cell.update(image: image)
                    }
            })
            { (error) in
                print(error)
            }
        }
        
        return cell
    }
}

extension MoviesSearchPresenter: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return searching ? 200 : 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if searching { return }
        
        self.searchBar?.text = searchQueriesModel.data[indexPath.row]
        self.searchBar?.resignFirstResponder()
    }
}
