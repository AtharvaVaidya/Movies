//
//  MockMovie.swift
//  MoviesTests
//
//  Created by Atharva Vaidya on 15/07/18.
//  Copyright © 2018 Atharva vaidya. All rights reserved.
//

import Foundation
@testable import Movies

struct MockMovie
{
    static func createMovie() -> Movie
    {
        return Movie(title: "Batman v Superman: Dawn of Justice", overview: "Fearing the actions of a god-like Super Hero left unchecked, Gotham City's own formidable, forceful vigilante takes on Metropolis's most revered, modern-day savior, while the world wrestles with what sort of hero it really needs. And with Batman and Superman at war with one another, a new threat quickly arises, putting mankind in greater danger than it's ever known before.", posterPath: "/cGOPbv9wA5gEejkUN892JrveARt.jpg", releaseDate: "2016-03-23")
    }
}
