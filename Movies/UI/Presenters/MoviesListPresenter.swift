//
//  MoviesListPresenter.swift
//  Movies
//
//  Created by Atharva Vaidya on 14/07/18.
//  Copyright © 2018 Atharva vaidya. All rights reserved.
//

import UIKit

class MoviesListPresenter: NSObject, MovieCellPosterDownloader
{
    var model: MovieListModel = MovieListModel()
    public weak var controller: MoviesListTableViewController?
    
    lazy var getMoviesQueue: OperationQueue =
    {
        var queue = OperationQueue()
        queue.name = "Search Movies Download queue"
        queue.maxConcurrentOperationCount = 1
        return queue
    }()
    
    var pendingOperations: PendingOperations
    {
        return pendingImageOperations
    }
    let pendingImageOperations: PendingOperations = PendingOperations()

    let title: String = "Movies"
    
    private var isLoadingData: Bool = false
    {
        didSet
        {
            DispatchQueue.main.async
            {
                _ = self.isLoadingData ? self.controller?.showLoadingIndicator() : self.controller?.hideLoadingIndicator()
            }
        }
    }
    
    private var currentPage: Int = 1
    
    override init()
    {
        super.init()
        
        loadData()
    }
    
    func loadData(_ onSuccess: (([Movie]) -> ())? = nil, _ onFailure: ((NetworkError) -> ())? = nil)
    {
        if isLoadingData { return }

        isLoadingData = true
        
        let getMoviesOperation = GetMovies(onSuccess:
        { (movies) in
            
            self.isLoadingData = false
            self.currentPage += 1
            self.updateModelAndUI(with: movies)
            
            onSuccess?(movies)
        })
        { (error) in
            self.isLoadingData = false
            
            onFailure?(error)
        }
        
        getMoviesOperation.currentPage = self.currentPage
        
        for (_, operation) in self.pendingImageOperations.downloadsInProgress
        {
            getMoviesOperation.addDependency(operation)
        }
        
        getMoviesQueue.addOperation(getMoviesOperation)
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
        
        let cell: MovieTableViewCell = Factory.TableViewCells.makeMovieTableViewCell(movie: movie, in: tableView)
        
        self.downloadPoster(movie: movie, for: cell, at: indexPath)
        
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

extension MoviesListPresenter
{
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool)
    {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height

        let dragLength = maximumOffset - currentOffset

        if dragLength <= 20
        {
            self.loadData()
        }
    }
}
