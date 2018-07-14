//
//  ImageRetrievalOperation.swift
//  Movies
//
//  Created by Atharva Vaidya on 14/07/18.
//  Copyright © 2018 Atharva vaidya. All rights reserved.
//

import UIKit

class ImageOperation: Operation<UIImage>
{
    let path: String
    
    init(path: String)
    {
        self.path = path
        
        guard let url = URL.init(string: "https://image.tmdb.org/t/p/w185")
        else
        {
            fatalError("could not initialize base url for Image Service")
        }
        
        let serviceConfig = ServiceConfig.init(base: url)
        let request =  Request(method: .get, endpoint: path)
        
        super.init(request: request, serviceConfig: serviceConfig)
    }
    
    override func parser() -> Parser<UIImage>
    {
        return ImageParser()
    }
}

class GetPoster: ImageOperation
{
    init(movie: Movie)
    {
        super.init(path: movie.posterPath)
    }
}
