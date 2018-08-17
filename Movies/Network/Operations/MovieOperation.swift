//
//  MoviesService.swift
//  Movies
//
//  Created by Atharva Vaidya on 13/07/18.
//  Copyright © 2018 Atharva vaidya. All rights reserved.
//

import UIKit

/// Generic operation to retrieve a movie
public class MovieOperation: NetworkOperation<[Movie]>
{
    let endPoint: String
    
    init(endPoint: String, page: Int = 1, onSuccess: (([Movie]) -> ())?, onFailure: ((NetworkError) -> ())?)
    {
        self.endPoint   = endPoint
        let request     = Request(method: .get, endpoint: self.endPoint, page: page)
        super.init(request: request, onSuccess: onSuccess, onFailure: onFailure)
    }
    
    override public func parser() -> Parser<[Movie]>
    {
        return MovieParser()
    }
}

/// Operation to get a list of movies sorted by their current popularity
class GetMovies: MovieOperation
{
    var currentPage: Int = 1
    {
        didSet
        {
            request = Request(method: .get, endpoint: self.endPoint, page: currentPage)
        }
    }
    
    init(onSuccess: (([Movie]) -> ())? = nil, onFailure: ((NetworkError) -> ())? = nil)
    {
        super.init(endPoint: "/discover/movie?api_key=\(Constants.APIKey)&sort_by=popularity.desc", page: currentPage, onSuccess: onSuccess, onFailure: onFailure)
    }
}

/// Operation to search for a movie with a given title
class SearchMovies: MovieOperation
{
    init(title: String, onSuccess: (([Movie]) -> ())?, onFailure: ((NetworkError) -> ())?)
    {
        super.init(endPoint: "/search/movie?api_key=\(Constants.APIKey)&query=\(title.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? title)", onSuccess: onSuccess, onFailure: onFailure)
    }
    
    convenience init(onSuccess: (([Movie]) -> ())?, onFailure: ((NetworkError) -> ())?)
    {
        self.init(title: "", onSuccess: onSuccess, onFailure: onFailure)
    }
}
