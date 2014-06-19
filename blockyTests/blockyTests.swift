//
//  blockyTests.swift
//  blockyTests
//
//  Created by Uberto Barbini on 15/06/14.
//  Copyright (c) 2014 Uberto Barbini. All rights reserved.
//

import XCTest
import blocky

class blockyTests: XCTestCase {
    
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
        XCTAssert(true, "Pass")
        
        
        var col = Column(size: 10)
        
        let v = col.size
        
        
        
        col.draw()
        
        
        var block = col.addBlock(2)
        
        
        col.draw()
        
        
        var block2 = col.addBlock(3)
        
        
        col.draw()
        
        
        col.addBlock(1)
        
        col.addBlock(10)
        
        
        col.draw()
        
        let nb = col.getBlockAt( 2)
        nb == nil
        
        let c = col.getBlockAt( 3)
        c!.size
        
        col.draw()
        
        
        let b = col.getBlockAt( 3)!
        b.moveDown()
        
         XCTAssertEqual(col.draw(), "##__###_#_", "Pass")
        
        
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
