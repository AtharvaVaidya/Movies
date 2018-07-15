//
//  MovieTableViewCellPosterDownloader.swift
//  Movies
//
//  Created by Atharva Vaidya on 15/07/18.
//  Copyright © 2018 Atharva vaidya. All rights reserved.
//

import Foundation

/// Protocol that be should adhered to if the object wants to download a movie poster for a given `MovieTableViewCell`
protocol MovieCellPosterDownloader
{
    /// Downloads the poster for a given movie.
    /// Tries to retrieve the poster from a temporary image cache if it exists otherwise downloads it.
    /// - Parameters:
    ///   - movie: The movie for which the poster has to be downloaded
    ///   - cell: The cell that the poster belongs to.
    func downloadPoster(movie: Movie, for cell: MovieTableViewCell)
}

extension MovieCellPosterDownloader
{
    func downloadPoster(movie: Movie, for cell: MovieTableViewCell)
    {
        if let cachedImage = Constants.postersCache.object(forKey: movie.posterPath as NSString)
        {
            cell.update(image: cachedImage)
        }
            
        else
        {
            GetPoster(movie: movie).execute(
            { (image) in
                    
                Constants.postersCache.setObject(image, forKey: movie.posterPath as NSString)
                
                if movie == cell.movie
                {
                    DispatchQueue.main.async
                    {
                        cell.update(image: image)
                    }
                }
            })
            { (error) in
                print(error)
            }
        }
    }
}
