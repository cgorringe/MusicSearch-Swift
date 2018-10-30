//
//  MusicSearchSTests.swift
//  MusicSearchSTests
//
//  Created by Carl Gorringe on 7/24/18.
//  Copyright © 2018 Carl Gorringe. All rights reserved.
//

import XCTest
@testable import MusicSearchS

class MusicSearchSTests: XCTestCase {

  let api = APIManager()

  override func setUp() {
    super.setUp()
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }

  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }

/*
  func testExample() {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
  }

  func testPerformanceExample() {
    // This is an example of a performance test case.
    self.measure {
      // Put the code you want to measure the time of here.
    }
  }
*/

  ////////////////////////////////////////////////////////////////////////////////////////////////////
  // MARK: - APIManager Tests

/*
  func testUrlEncodedValue() {

    let test1 = api.urlEncodedValue("example")
    XCTAssertEqual(test1, "example")

    let test2 = api.urlEncodedValue("here are some spaces")
    XCTAssertEqual(test2, "here+are+some+spaces")

    let test3 = api.urlEncodedValue("unreserved123-_.~")
    XCTAssertEqual(test3, "unreserved123-_.~")

    let test4 = api.urlEncodedValue("ampersand&ampersand")
    XCTAssertEqual(test4, "ampersand%26ampersand")

    let test5 = api.urlEncodedValue("plus+plus")
    XCTAssertEqual(test5, "plus+plus")   // should be escaped!

    let test6 = api.urlEncodedValue("colon:colon")
    XCTAssertEqual(test6, "colon:colon")   // not sure?

    let test7 = api.urlEncodedValue("percent%percent")
    XCTAssertEqual(test7, "percent%25percent")

    let test8 = api.urlEncodedValue("equals=equals")
    XCTAssertEqual(test8, "equals=equals")  // should be escaped!

    let test9 = api.urlEncodedValue("q?q")
    XCTAssertEqual(test9, "q?q")  // should be escaped!

    let test10 = api.urlEncodedValue(":/?#[]@!$&'()*+,;=")
    XCTAssertEqual(test10, ":/?%23%5B%5D@!$%26'()*+,;=")   // not correct?
  }
*/

}
