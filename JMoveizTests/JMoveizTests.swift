//
//  JMoveizTests.swift
//  JMoveizTests
//
//  Created by Mahmoud Eissa on 12/31/23.
//

import XCTest
import SwiftUI
import  Combine

@testable import JMoveiz

final class JZMoviesListViewModelTests: XCTestCase {
    
    private var sut: JZMoviesListViewModel!
    private var reachability: JZMockNetworkReachability!
    private var cancelBag = Set<AnyCancellable>()
    
    override func setUp() {
        super.setUp()
        let configuration: URLSessionConfiguration = {
            let configuration = URLSessionConfiguration.default
            configuration.protocolClasses = [MockURLProtocol.self]
            configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
            return configuration
        }()
        MockURLProtocol.responseType = .success(data: .init(file: "Response"))
        JZNetworkManager.configure(configuration)
        reachability = JZMockNetworkReachability()
        sut = .init(service: JZMoviesListService(), reachability: reachability!)
    }
    
    func testMoviesListViewModel_whenRequestInitialItems_willLoadInitialItems() throws {
        let publisher = sut.$items
            .dropFirst()
            .collect(1)
            .first()
        
        sut.requestInitialSetOfItems()
        let results = try awaitPublisher(publisher, timeout: 2)
        XCTAssertEqual(results.first?.count, 20)
        XCTAssertEqual(results.first?.first?.id, 695721)
    }
    
    func testMoviesListViewModel_whenScroll_willRequestNextPage() throws {
        let publisher = sut.$items
            .dropFirst()
            .collect(1)
            .first()

        sut.requestInitialSetOfItems()
        let results = try awaitPublisher(publisher, timeout: 4)
        XCTAssertEqual(results.first?.count, 20)
        XCTAssertEqual(results.first?.first?.id, 695721)
        
        let nextPagePublisher = sut.$items
            .dropFirst()
            .collect(1)
            .first()

        sut.items.forEach(sut.onItemAppear)

        let nextPageResults = try awaitPublisher(nextPagePublisher, timeout: 4)

        XCTAssertEqual(nextPageResults.first?.count, 40)
        XCTAssertEqual(nextPageResults.first?.first?.id, 695721)
    }
    
    func testMoviesListViewModel_whenRequestInitialItems_willStartLoading() throws {
        let publisher = sut.$isLoading
            .collect(1)
            .first()
        
        sut.requestInitialSetOfItems()
        let results = try awaitPublisher(publisher, timeout: 2)
        XCTAssertEqual(results.first, true)
    }
    
    func testMoviesListViewModel_whenRequestInitialItems_whenFail_willEmitError() throws {
        MockURLProtocol.responseType = .error(NSError(error: "test_error", code: 404))
        let publisher = sut.$error
            .compactMap { $0 }
            .collect(1)
            .first()

        sut.requestInitialSetOfItems()
        let results = try awaitPublisher(publisher, timeout: 4)
        XCTAssertEqual(results.first?.localizedDescription.contains("test_error"), true)
    }
    
    func testMoviesListViewModel_whenConnectLost_willRetriveCache() throws {
        JZRealmManager.clear()
        let data = """
            {
                "adult": false,
                "backdrop_path": "/sy0vo1cmpKqwPRiMUiJ45jyLsX7.jpg",
                "genre_ids": [
                    10751,
                    35,
                    14
                ],
                "id": 8871,
                "original_language": "en",
                "original_title": "How the Grinch Stole Christmas",
                "overview": "The Grinch decides to rob Whoville of Christmas - but a dash of kindness from little Cindy Lou Who and her family may be enough to melt his heart...",
                "popularity": 489.391,
                "poster_path": "/AmUs3hximCKa90sHuIRr5Bz8ci5.jpg",
                "release_date": "2000-11-17",
                "title": "How the Grinch Stole Christmas",
                "video": false,
                "vote_average": 6.8,
                "vote_count": 6969
            }
            """.data(using: .utf8)!
        
        let item = try! JSONDecoder().decode(JZMovie.self, from: data)
        item.store()

        let publisher = sut.$items
            .collect(1)
            .first()

        reachability.isConnected = false
        let results = try awaitPublisher(publisher, timeout: 2)
        XCTAssertEqual(results.first?.count, 1)
        XCTAssertEqual(results.first?.first?.id, 8871)
    }
    
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        reachability = nil
    }
}
