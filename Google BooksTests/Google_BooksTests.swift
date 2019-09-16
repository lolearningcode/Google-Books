//
//  Google_BooksTests.swift
//  Google BooksTests
//
//  Created by Lo Howard on 9/13/19.
//  Copyright © 2019 Lo Howard. All rights reserved.
//

import XCTest
@testable import Google_Books

class Google_BooksTests: XCTestCase {
    
    let service = BooksController.shared
    let coreSerive = CoreDataBooks.shared

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchImages() {
        var volumeInfo = [VolumeInfo]()
        var image = UIImage()
        let promise = expectation(description: "waiting for service call")
        
        service.fetchBookImage(bookItems: volumeInfo.first!) { (fetchedImage) in
            image = fetchedImage!
            promise.fulfill()
        }
        
        waitForExpectations(timeout: 3, handler: nil)
        
        XCTAssert(volumeInfo.isEmpty)
    }

    func testFetchBooks() {
        var books = [Item]()
        
        let promise = expectation(description: "waiting for service call")
        
        service.fetchBooks(books: "Kyballion") { (fetchedBooks) in
            books = fetchedBooks
            promise.fulfill()
        }
        
        waitForExpectations(timeout: 3, handler: nil)
        
        XCTAssert(books.count > 2)
    }

    func testCoreDataEntries() {
        
        XCTAssertTrue(coreSerive.load().isEmpty)
        
        
    }
}
