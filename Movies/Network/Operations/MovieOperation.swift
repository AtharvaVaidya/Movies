//
//  MoviesService.swift
//  Movies
//
//  Created by Atharva Vaidya on 13/07/18.
//  Copyright © 2018 Atharva vaidya. All rights reserved.
//

import Foundation

public class MovieOperation: Operation<[Movie]>
{
    let endPoint: String
    
    init(endPoint: String)
    {
        self.endPoint   = endPoint
        let request     = Request(method: .get, endpoint: self.endPoint)
        super.init(request: request)
    }
    
    override public func parser() -> Parser<[Movie]>
    {
        return MovieParser()
    }
}

class GetMovies: MovieOperation
{
    init()
    {
        super.init(endPoint: "/discover/movie?api_key=\(Constants.APIKey)&sort_by=popularity.desc")
    }
}

class SearchMovies: MovieOperation
{
    init(title: String)
    {
        super.init(endPoint: "/search/movie?api_key=\(Constants.APIKey)&query=\(title)")
    }
}
