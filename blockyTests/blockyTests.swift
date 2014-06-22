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
    
    var col = Column(colName: "myCol", size: 10)
    
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testStartEmpty() {
        
        XCTAssertEqual(col.draw(), "__________", "Pass")
        
    }
    
    
    func testStartFillWithBlocks() {
        
        
        var block = col.addBlock(2)
        
        
        XCTAssertEqual(col.draw(), "##________", "Pass")
        
        
        var block2 = col.addBlock(3)
        
        
        XCTAssertEqual(col.draw(), "##_###____", "Pass")
        
        
        col.addBlock(1)
        
        XCTAssertFalse(col.addBlock(10))
        
        
        
        XCTAssertEqual(col.draw(), "##_###_#__", "Pass")
        
        
    }
    
    func testGetBlockAtPosition() {
        
        col.addBlocks(2, 3, 1)
        
        
        XCTAssertNil(col.getBlockAt( 2));
        
        let c = col.getBlockAt( 3)!
        
        XCTAssertEqual(c.size, 3);
      
        
    }
    

    
    
    func testGetBlockByName() {
        
       col.addBlocks(2, 3, 1)
        
        XCTAssertEqual(2, col.getBlockByName("block 0")!.size, "Pass")
        XCTAssertEqual(3, col.getBlockByName("block 1")!.size, "Pass")
        XCTAssertEqual(1, col.getBlockByName("block 2")!.size, "Pass")
        

        
    }
    
    func testMoveDown() {
        
        col.addBlocks(2, 3, 1)
        
        let c = col.getBlockByName("block 1")!
        
        XCTAssertTrue( c.moveDown())
        
        XCTAssertEqual(col.draw(), "##__###_#_", "Pass")
        
        XCTAssertTrue( c.moveDown())
        
        XCTAssertEqual(col.draw(), "##___###_#", "Pass")
        
        XCTAssertFalse( c.moveDown())
        
        XCTAssertEqual(col.draw(), "##___###_#", "Pass")
        
    }
    

    func testMoveUp() {
        
        col.addBlock(2)
        col.addBlock(3)
        col.addBlock(1)
        
        let c = col.getBlockAt(0)!
        
        XCTAssertTrue( c.moveDown())
        XCTAssertTrue( c.moveDown())
        
        XCTAssertEqual(col.draw(), "__##_###_#", "Pass")
        
        XCTAssertTrue( c.moveUp())
        
        XCTAssertEqual(col.draw(), "_##__###_#", "Pass")
        
        let b = col.getBlockAt(9)!
        
        XCTAssertTrue( b.moveUp())
        
        XCTAssertEqual(col.draw(), "_##_###_#_", "Pass")
        
    }
    
    
    func testGrid() {
        var grid = Grid(size: 5)
        
        XCTAssertEqual(grid.columns.count, 5, "Pass")
        XCTAssertEqual(grid.columns[0].size, 5, "Pass")
        XCTAssertEqual(grid.columns[4].size, 5, "Pass")
        
    }
    
    
    func testBinary() {
        let x = 5
        
        let bx = 0b101
        
        let ex = 0xFF0000
        
        XCTAssertEqual(x, Int(bx), "Pass")
        
        
    }

    
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measureBlock() {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
}
