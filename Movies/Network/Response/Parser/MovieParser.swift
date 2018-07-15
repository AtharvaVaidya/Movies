//
//  File.swift
//  Movies
//
//  Created by Atharva Vaidya on 14/07/18.
//  Copyright © 2018 Atharva vaidya. All rights reserved.
//

import Foundation

/// Parser for a movie
public class MovieParser: Parser<[Movie]>
{    
    /// Parses a movie from the Data obtained from a API response regarding a Movie.
    ///
    /// - Parameter data: The data from the response
    /// - Returns: An array of movies parsed from the response
    /// - Throws: Failed to parse JSON if it cannot parse the response.
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
