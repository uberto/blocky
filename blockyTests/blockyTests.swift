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
    
    func startEmpty() {
        var col = Column(size: 10)
        
        XCTAssertEqual(col.draw(), "__________", "Pass")
        
    }
    
    
    func startFillWithBlocks() {
        
        var col = Column(size: 10)
        
        var block = col.addBlock(2)
        
        
        XCTAssertEqual(col.draw(), "##________", "Pass")
        
        
        var block2 = col.addBlock(3)
        
        
        XCTAssertEqual(col.draw(), "##_###____", "Pass")
        
        
        col.addBlock(1)
        
        XCTAssertFalse(col.addBlock(10))
        
        
        
        XCTAssertEqual(col.draw(), "##_###_#__", "Pass")
        
        
    }
    
    func getBlockAtPosition() {
        
        var col = Column(size: 10)
        col.addBlock(2)
        col.addBlock(3)
        col.addBlock(1)
        
        
        XCTAssertNil(col.getBlockAt( 2));
        
        let c = col.getBlockAt( 3)!
        
        XCTAssertEqual(c.size, 3);
      
        
    }
    
    
    func moveDown() {
        
        var col = Column(size: 10)
        col.addBlock(2)
        col.addBlock(3)
        col.addBlock(1)
        
        let c = col.getBlockAt( 3)!
        
        XCTAssertTrue( c.moveDown())
        
        XCTAssertEqual(col.draw(), "##__###_#_", "Pass")
        
        XCTAssertTrue( c.moveDown())
        
        XCTAssertEqual(col.draw(), "##___###_#", "Pass")
        
        XCTAssertFalse( c.moveDown())
        
        XCTAssertEqual(col.draw(), "##___###_#", "Pass")
        
    }
    
    func moveUp() {
        
        var col = Column(size: 10)
        col.addBlock(2)
        col.addBlock(3)
        col.addBlock(1)
        
        let c = col.getBlockAt(0)!
        
        XCTAssertTrue( c.moveDown())
        XCTAssertTrue( c.moveDown())
        
        XCTAssertEqual(col.draw(), "11__##_###_#", "Pass")
        
        XCTAssertTrue( c.moveUp())
        
        XCTAssertEqual(col.draw(), "_##__###_#", "Pass")
        
        let b = col.getBlockAt(0)!
        
        XCTAssertFalse( b.moveUp())
        
        XCTAssertEqual(col.draw(), "_##_###__#", "Pass")
        
    }
    

    
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measureBlock() {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
}
