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
    var model: MovieListModel = MovieListModel()
    public weak var controller: MoviesListTableViewController?
    let getMoviesOperation: GetMovies = GetMovies()
    
    private let imageCache: NSCache<NSString, UIImage> =
    {
        let cache = NSCache<NSString, UIImage>()
        cache.name = "Posters Cache"
        return cache
    }()
    
    let title: String = "Discover"
    
    private var isLoadingData: Bool = false
    
    override init()
    {
        super.init()
        
        loadData()
    }
    
    func loadData()
    {
        if isLoadingData { return }

        isLoadingData = true
        
        getMoviesOperation.execute(
        { (movies) in
            
            self.isLoadingData = false
            self.getMoviesOperation.currentPage += 1
        
            self.updateModelAndUI(with: movies)
            
        })
        { (error) in
            self.isLoadingData = false
            print(error.localizedDescription)
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
        
        if dragLength <= 50
        {
            self.loadData()
        }
    }
}
