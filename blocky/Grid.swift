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
    
    let rowHints: RowHint[]
    
    init(size: Int){
    
        columns = Column[]()
        rowHints = RowHint[]()
        
        for i in 0..size{
            columns.append(Column(colName: "col \(i)", size: size))
            rowHints.append(RowHint())
        }
    }
    
    func getColumnByName(colName: String) -> Column? {
        for col in columns{
            if col.name == colName{
                return col
            }
        }
        return nil
    }
    
    func calculateRow(row: Int) -> RowHint {
        
        var blockLengths: Int[] = Int[]()
        
        var currBlockSize = 0
        for col in columns {
            if let block = col.getBlockAt(row)  {
                currBlockSize += 1
            } else if currBlockSize > 0 {
                blockLengths.append(currBlockSize)
                currBlockSize = 0
            }
        }
        if currBlockSize > 0 {
            blockLengths.append(currBlockSize)
        }

        return RowHint(hintArray: blockLengths)

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

        grid.rowHints[ 0] = RowHint(hints: 5)
        grid.rowHints[ 1] = RowHint(hints: 1,1)
        grid.rowHints[ 2] = RowHint(hints: 3,1,1)
        grid.rowHints[ 3] = RowHint(hints: 2,3,2,2)
        grid.rowHints[ 4] = RowHint(hints: 2,3)
        grid.rowHints[ 5] = RowHint(hints: 1,4)
        grid.rowHints[ 6] = RowHint(hints: 1,11)
        grid.rowHints[ 7] = RowHint(hints: 1,10,1)
        grid.rowHints[ 8] = RowHint(hints: 3,8,1)
        grid.rowHints[ 9] = RowHint(hints: 5,4,2)
        grid.rowHints[ 10] = RowHint(hints: 14)
        grid.rowHints[ 11] = RowHint(hints: 1,7)
        grid.rowHints[ 12] = RowHint(hints: 7,4,1)
        grid.rowHints[ 13] = RowHint(hints: 2,5,2)
        grid.rowHints[ 14] = RowHint(hints: 9, 3 )
        
        return grid
    }
    
    
    class func createNinja() -> Grid{
        let grid = Grid(size: 25)
        
        grid.columns[  0].addBlocks(3,1 )
        grid.columns[  1].addBlocks(1,1,1 )
        grid.columns[  2].addBlocks(3,1 )
        grid.columns[  3].addBlocks(3,1 )
        grid.columns[  4].addBlocks(4,3,1 )
        grid.columns[  5].addBlocks(6,5,5,1 )
        grid.columns[  6].addBlocks(2,1,7,6,1 )
        grid.columns[  7].addBlocks(3,3,5,7,1 )
        grid.columns[  8].addBlocks(3,1,4,3,8,1 )
        grid.columns[  9].addBlocks(3,3,1,3,8 )
        grid.columns[ 10].addBlocks(10,1,2,4,4 )
        grid.columns[ 11 ].addBlocks(8,5,3,3 )
        grid.columns[ 12 ].addBlocks(2,8,2 )
        grid.columns[ 13 ].addBlocks(1,9,4,1 )
        grid.columns[ 14 ].addBlocks( 1,9,6,1)
        grid.columns[ 15 ].addBlocks(1,2,3,2,8,1 )
        grid.columns[ 16 ].addBlocks(1,2,3,9,1 )
        grid.columns[ 17 ].addBlocks(1,2,4,8,1 )
        grid.columns[ 18 ].addBlocks(1,1,3,4,1 )
        grid.columns[ 19 ].addBlocks(1,5,1,4,1 )
        grid.columns[ 20 ].addBlocks(2,1,2,1,1,3 )
        grid.columns[ 21 ].addBlocks(2,2,1,3,1,4 )
        grid.columns[ 22 ].addBlocks(2,2,1,2,1,3 )
        grid.columns[ 23 ].addBlocks( 2,2,2,1,2,1)
        grid.columns[ 24 ].addBlocks( 2,2,2,2,3,2,1)

        return grid
    }
    
    
    class func createBubbleSoap() -> Grid{
        let grid = Grid(size: 20)
        
        grid.columns[0].addBlocks(3,5)
        grid.columns[1].addBlocks(5,2,2,2)
        grid.columns[2].addBlocks(2,2,1,1,2,1)
        grid.columns[3].addBlocks(2,3,2,1,2,1)
        grid.columns[4].addBlocks(1,1,1,1,1,1)
        grid.columns[5].addBlocks(1,1,2,2)
        grid.columns[6].addBlocks(1,1,5)
        grid.columns[7].addBlocks(2,2,1)
        grid.columns[8].addBlocks(2,2,7)
        grid.columns[9].addBlocks(5,1,1,1)
        grid.columns[10].addBlocks(1,1,3)
        grid.columns[11].addBlocks(5,1)
        grid.columns[12].addBlocks(3,4,1,1)
        grid.columns[13].addBlocks(2,11,1)
        grid.columns[14].addBlocks(2,2,5,1,1,1)
        grid.columns[15].addBlocks(1,1,4,2,1,3)
        grid.columns[16].addBlocks(1,5,2,2)
        grid.columns[17].addBlocks(1,6,2)
        grid.columns[18].addBlocks(2,8,4)
        grid.columns[19].addBlocks(2,10,1)
        
        grid.rowHints[0] = RowHint(hints: 5,1,1)
        grid.rowHints[1] = RowHint(hints: 2,2,1,1)
        grid.rowHints[2] = RowHint(hints: 2,1,2,2,1,1)
        grid.rowHints[3] = RowHint(hints: 1,1,1,2,2)
        grid.rowHints[4] = RowHint(hints: 1,1,1,5)
        grid.rowHints[5] = RowHint(hints: 1,1,1)
        grid.rowHints[6] = RowHint(hints: 2,1,2,5)
        grid.rowHints[7] = RowHint(hints: 1,2,2,7)
        grid.rowHints[8] = RowHint(hints: 1,5,8)
        grid.rowHints[9] = RowHint(hints: 2,8)
        grid.rowHints[10] = RowHint(hints: 3,3,4)
        grid.rowHints[11] = RowHint(hints: 2,3)
        grid.rowHints[12] = RowHint(hints: 5,1,2,2)
        grid.rowHints[13] = RowHint(hints: 2,1,2,4,1,2,2)
        grid.rowHints[14] = RowHint(hints: 1,1,1,1,1,1,1)
        grid.rowHints[15] = RowHint(hints: 1,1,10,1)
        grid.rowHints[16] = RowHint(hints: 1,1,1,1,1,2)
        grid.rowHints[17] = RowHint(hints: 2,2,1,2,3,1)
        grid.rowHints[18] = RowHint(hints: 5,1,1,4)
        grid.rowHints[19] = RowHint(hints: 12)
        
        return grid
    }

    
}



class RowHint {
    let hints : Int[]
    
    init (hints: Int...) {
        self.hints = hints
    }

    init (hintArray: Int[]) {
        self.hints = hintArray
    }
    
    func description() -> String {
        return hints.map {
            (var number) -> String in
            return String(number)
            }.reduce(""){ str, next in (str + " " + next) }


    }
}


