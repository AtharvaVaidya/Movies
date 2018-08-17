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
    
    var searchOperation: Operation = Operation()
    
    lazy var queue: OperationQueue =
    {
        var queue = OperationQueue()
        queue.name = "Search Movies Download queue"
        queue.maxConcurrentOperationCount = 1
        return queue
    }()
    
    let pendingOperations: PendingOperations = PendingOperations()
    
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
    
    func search(title: String, _ onSuccess: (([Movie]) -> ())? = nil, _ onFailure: ((NetworkError) -> ())? = nil)
    {
        self.controller?.showLoadingIndicator()
        
        self.searchOperation = SearchMovies(title: title, onSuccess: { (movies) in
            self.controller?.hideLoadingIndicator()
            self.updateModelAndUI(with: movies)
            onSuccess?(movies)
        }, onFailure: { (error) in
            print(error.localizedDescription)
            self.controller?.hideLoadingIndicator()
            onFailure?(error)
        })
        
        for (_, operation) in self.pendingOperations.downloadsInProgress
        {
            self.searchOperation.addDependency(operation)
        }
        
        self.queue.addOperation(searchOperation)
    }
    
    func start(operation: Operation)
    {
        
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
    
        self.model.data = []
        self.controller?.tableView.reloadData()
        
//        queue.cancelAllOperations()
        
        search(title: searchText,
        { (movies) in
            if movies.isEmpty
            {
                self.controller?.presentNotification(text: "Error", subText: "No movies found with title \(searchText)")
            }
            else { self.searchQueriesModel.add(query: searchText) }
        })
        { (error) in
            self.controller?.presentNotification(text: "Error", subText: "\(error.localizedDescription)")
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        self.model.data = []
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
    }
}

extension MoviesSearchPresenter: MovieCellPosterDownloader {}

extension MoviesSearchPresenter: UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return searching ? model.data.count : searchQueriesModel.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if !searching
        {
            guard let query = searchQueriesModel.data[safe: indexPath.row] else { return UITableViewCell() }
            
            return Factory.TableViewCells.makeSearchQueryCell(query: query, in: tableView)
        }
        
        guard let movie = model.data[safe: indexPath.row] else { return UITableViewCell() }
        
        let cell: MovieTableViewCell = Factory.TableViewCells.makeMovieTableViewCell(movie: movie, in: tableView)
        
        self.downloadPoster(movie: movie, for: cell, at: indexPath)
        
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
        
        let query = searchQueriesModel.data[indexPath.row]
        
        self.searchBar?.text = query
        self.searchBar?.resignFirstResponder()
        
        search(title: query)
    }
}
