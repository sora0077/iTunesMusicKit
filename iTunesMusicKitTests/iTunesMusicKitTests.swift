//
//  iTunesMusicKitTests.swift
//  iTunesMusicKitTests
//
//  Created by 林達也 on 2015/10/14.
//  Copyright © 2015年 jp.sora0077. All rights reserved.
//

import XCTest
import APIKit
@testable import iTunesMusicKit

extension ListGenres: DebugRequestToken {}
extension GetPreviewUrl: DebugRequestToken {}

extension XCTestCase {
    
    func async(callback: (() -> Void) -> Void) {
        
        let expect = self.expectationWithDescription("")
        
        callback {
            expect.fulfill()
        }
        
        self.waitForExpectationsWithTimeout(40) { (error) -> Void in
            
        }
    }
    
}

class iTunesMusicKitTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        
        let itunes = iTunesMusicAPI()
        
        async { done in
            let url = "https://itunes.apple.com/jp/album/rising-hope/id862874145?i=862874227"
            itunes.request(GetPreviewUrl(id: "862874227", url: url)).onSuccess { v in
             
                print(v)
                done()
            }
//            itunes.request(ListGenres(country: "JP")).onSuccess { v in
//                
//                print(v)
//                
//                done()
//            }
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
