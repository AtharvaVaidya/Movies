//
//  ImageRetrievalOperation.swift
//  Movies
//
//  Created by Atharva Vaidya on 14/07/18.
//  Copyright © 2018 Atharva vaidya. All rights reserved.
//

import UIKit

/// An operation to download a poster from the API
class GetPoster: NetworkOperation<UIImage>
{
    let path: String
    
    init(path: String, onSuccess: ((UIImage) -> ())?, onFailure: ((NetworkError) -> ())?)
    {
        self.path = path
        
        guard let url = URL.init(string: "https://image.tmdb.org/t/p/w185")
        else
        {
            fatalError("could not initialize base url for Image Service")
        }
        
        let serviceConfig = ServiceConfig.init(base: url)
        let request =  Request(method: .get, endpoint: path)
        
        super.init(request: request, serviceConfig: serviceConfig, onSuccess: onSuccess, onFailure: onFailure)
    }
    
    @discardableResult convenience init(movie: Movie, onSuccess: ((UIImage) -> ())?, onFailure: ((NetworkError) -> ())?)
    {
        self.init(path: movie.posterPath, onSuccess: onSuccess, onFailure: onFailure)
    }
    
    override func parser() -> Parser<UIImage>
    {
        return ImageParser()
    }
}

