//
//  File.swift
//  Movies
//
//  Created by Atharva Vaidya on 14/07/18.
//  Copyright © 2018 Atharva vaidya. All rights reserved.
//

import Foundation

public class MovieParser: Parser<[Movie]>
{    
    override public func parse(data: Data) throws -> [Movie]
    {
        do
        {
            guard let dictObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary,
                  let results = dictObject["results"] as? [NSDictionary]
            else
            {
                return []
            }
            
            var movies: [Movie] = []
            
            for movieDict in results
            {
                do
                {
                    let movieData = try JSONSerialization.data(withJSONObject: movieDict, options: .sortedKeys)
                    let jsonDecoder = JSONDecoder()
                    let movie = try jsonDecoder.decode(Movie.self, from:  movieData)
                    movies.append(movie)
                }
                    
                catch
                {
                    continue
//                    throw NetworkError.failedToParseJSONDictionary(movieDict as! [String : Any?])
                }
            }
            
            return movies
        }
        catch
        {
            throw NetworkError.failedToParseJSONData(data)
        }
    }
}
