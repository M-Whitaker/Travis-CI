//
//  Travis_CIUnitTests.swift
//  Travis-CIUnitTests
//
//  Created by Matt Whitaker on 24/02/2020.
//  Copyright © 2020 Matt Whitaker. All rights reserved.
//

import XCTest
@testable import Travis_CI

class Travis_CIUnitTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTimeAgoDisplay() {
        let fiveMinsAgo = Date(timeIntervalSinceNow: -5 * 60)
        let fiveMinsAgoDisplay = fiveMinsAgo.timeAgoDisplay()
        let oneMinsAgo = Date(timeIntervalSinceNow: -1 * 60)
        let oneMinsAgoDisplay = oneMinsAgo.timeAgoDisplay()
        
        XCTAssertEqual(fiveMinsAgoDisplay, "5 Minutes Ago")
        XCTAssertEqual(oneMinsAgoDisplay, "1 Minute Ago")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
