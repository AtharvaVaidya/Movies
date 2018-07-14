//
//  MoviesService.swift
//  Movies
//
//  Created by Atharva Vaidya on 13/07/18.
//  Copyright © 2018 Atharva vaidya. All rights reserved.
//

import Foundation

class MoviesService: Service
{
    func getMovies(_ success: @escaping ([Movie]) -> (), _ failure: (NetworkError) -> ())
    {
        let request = Request(method: .get, endpoint: "/discover/movie?api_key=2696829a81b1b5827d515ff121700838&sort_by=popularity.desc", params: nil, fields: nil, body: nil)
        self.execute(request: request, { (resultData) in
            
        })
        { (error) in
            print(error.localizedDescription)
        }
    }
    
    func searchMovies(with title: String)
    {
        
    }
}
