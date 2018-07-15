//
//  GetMoviesTests.swift
//  MoviesTests
//
//  Created by Atharva Vaidya on 15/07/18.
//  Copyright © 2018 Atharva vaidya. All rights reserved.
//

import XCTest
@testable import Movies

class NetworkTests: XCTestCase
{
    var getMoviesOperation: GetMovies!
    var searchMoviesOperation: SearchMovies!
    var imageDownloadOperation: GetPoster!
    
    override func setUp()
    {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        getMoviesOperation = GetMovies()
        searchMoviesOperation = SearchMovies(title: "The Dark Knight")
        imageDownloadOperation = GetPoster(movie: Movie(title: "Batman v Superman: Dawn of Justice", overview: "Fearing the actions of a god-like Super Hero left unchecked, Gotham City's own formidable, forceful vigilante takes on Metropolis's most revered, modern-day savior, while the world wrestles with what sort of hero it really needs. And with Batman and Superman at war with one another, a new threat quickly arises, putting mankind in greater danger than it's ever known before.", posterPath: "/cGOPbv9wA5gEejkUN892JrveARt.jpg", releaseDate: "2016-03-23"))
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        getMoviesOperation = nil
        searchMoviesOperation = nil
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testGetMovies()
    {
        getMoviesOperation.execute({ (movies) in
            XCTAssert(!movies.isEmpty)
        })
        { (error) in
            XCTFail(error.localizedDescription)
        }
    }
    
    func testSearch()
    {
        searchMoviesOperation.execute({ (movies) in
            XCTAssert(!movies.isEmpty)
        }) { (error) in
            XCTFail(error.localizedDescription)
        }
    }
    
    func testPosterDownload()
    {
        imageDownloadOperation.execute(
        { (image) in
            XCTAssert(image.size != .zero)
            
        })
        { (error) in
            XCTFail(error.localizedDescription)
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
