//
//  MoviesService.swift
//  Movies
//
//  Created by Atharva Vaidya on 13/07/18.
//  Copyright © 2018 Atharva vaidya. All rights reserved.
//

import Foundation

public class MovieRetrievalOperation: OperationProtocol
{
    typealias T = [Movie]
    
    let parser:     MovieServiceParser  = MovieServiceParser()
    let service:    Service             = Service(ServiceConfig.appConfig())
    
    let endPoint:   String
    var request:    RequestProtocol
    
    init(endPoint: String)
    {
        self.endPoint   = endPoint
        self.request    = Request(method: .get, endpoint: self.endPoint, params: nil, fields: nil, body: nil)
    }
    
    func execute(_ success: @escaping ([Movie]) -> (), _ failure: @escaping (NetworkError) -> ())
    {
        service.execute(request: request,
        { (resultData) in
            do
            {
                success(try self.parser.parseJSON(data: resultData))
            }
                
            catch
            {
                failure(NetworkError.failedToParseJSONData(resultData))
            }
        })
        { (error) in
            failure(error)
        }
    }
}

class GetMovies: MovieRetrievalOperation
{
    init()
    {
        super.init(endPoint: "/discover/movie?api_key=\(Constants.APIKey)&sort_by=popularity.desc")
    }
}

class SearchMovies: MovieRetrievalOperation
{
    init(title: String)
    {
        super.init(endPoint: "/search/movie?api_key=\(Constants.APIKey)&query=\(title)")
    }
}
