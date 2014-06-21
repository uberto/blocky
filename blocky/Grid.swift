//
//  Grid.swift
//  blocky
//
//  Created by Uberto Barbini on 21/06/14.
//  Copyright (c) 2014 Uberto Barbini. All rights reserved.
//

import Foundation


class Grid {
    
    let columns: Column[]
    
    init(size: Int){
    
        columns = Column[]()
        for i in 0..size{
            columns.append(Column(size: size))
            
        }
        
    }
    
    
    class func createCatFish() -> Grid{
        let grid = Grid(size: 15)
        
        grid.columns[0].addBlocks(5, 4)
        grid.columns[1].addBlocks(2, 3, 3)
        grid.columns[2].addBlocks(2,4,1,1)
        grid.columns[3].addBlocks(1,2,2,1,1)
        grid.columns[4].addBlocks(2,5,1,1)
        grid.columns[5].addBlocks(1,5,1,1)
        grid.columns[6].addBlocks(1,3,1,1,1)
        grid.columns[7].addBlocks(5,2)
        grid.columns[8].addBlocks(9)
        grid.columns[9].addBlocks(9)
        grid.columns[10].addBlocks(4,9)
        grid.columns[11].addBlocks(1,6,5)
        grid.columns[12].addBlocks(1,3,3,1)
        grid.columns[13].addBlocks(1,9,2)
        grid.columns[14].addBlocks(4,3)
        
        return grid
    }
}
