//
//  Movie.swift
//  Movies
//
//  Created by Atharva Vaidya on 13/07/18.
//  Copyright © 2018 Atharva vaidya. All rights reserved.
//

import Foundation

/// A struct that encapsulates all the data about a movie.
public struct Movie: Codable, Equatable
{
    let title:       String
    let overview:    String
    let posterPath:  String
    let releaseDate: String
    
    enum CodingKeys: String, CodingKey
    {
        case title = "title"
        case overview = "overview"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
    }
}

extension Movie: CustomStringConvertible
{
    public var description: String
    {
        return title
    }
}

extension Movie
{
    /// Convenience function that returns a string with the title and release year. Example: The Dark Knight (2008)
    var titleAndReleaseYear: String
    {
        return "\(title) \(releaseYear == nil ? "" : "(\(releaseYear ?? ""))")"
    }
    
    var releaseYear: String?
    {
        let dateFormatter           = DateFormatter()
        dateFormatter.dateFormat    = "yyyy-mm-dd"
        guard let date              = dateFormatter.date(from: self.releaseDate) else { return nil }
        
        dateFormatter.dateFormat    = "yyyy"
        
        return dateFormatter.string(from: date)
    }
}

