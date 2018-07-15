//
//  MovieTableViewCellPosterDownloader.swift
//  Movies
//
//  Created by Atharva Vaidya on 15/07/18.
//  Copyright © 2018 Atharva vaidya. All rights reserved.
//

import Foundation

protocol MovieCellPosterDownloader
{
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
