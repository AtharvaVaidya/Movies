//
//  PresenterTests.swift
//  MoviesTests
//
//  Created by Atharva Vaidya on 15/07/18.
//  Copyright © 2018 Atharva vaidya. All rights reserved.
//

import XCTest
@testable import Movies

class PresenterTests: XCTestCase
{
    var moviesListPresenter: MoviesListPresenter!
    var searchPresenter: MoviesSearchPresenter!
    
    override func setUp()
    {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        moviesListPresenter = MoviesListPresenter()
        searchPresenter = MoviesSearchPresenter()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        moviesListPresenter = nil
        searchPresenter = nil
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testMoviesListPresenterLoadData()
    {
        moviesListPresenter.loadData({ (movies) in
            XCTAssert(!movies.isEmpty)
        }) { (error) in
            XCTFail(error.localizedDescription)
        }
    }
    
    func testSearchPresenterLoadData()
    {
        searchPresenter.search(title: "The Dark Knight", { (movies) in
            XCTAssert(!movies.isEmpty)
        })
        { (error) in
            XCTFail(error.localizedDescription)
        }
    }
    
    func testSearchPresenterUpdatesController()
    {
        searchPresenter.search(title: "The Dark Knight", { (movies) in
            XCTAssert(!movies.isEmpty)
            XCTAssert(self.searchPresenter.model.data == movies)
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
