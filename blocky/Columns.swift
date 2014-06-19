//
//  Columns.swift
//  blocky
//
//  Created by Uberto Barbini on 19/06/14.
//  Copyright (c) 2014 Uberto Barbini. All rights reserved.
//

import Foundation


operator infix ** {}
@infix func ** (left: String, right: Int) -> String {
    var repeatedString = ""
    for _ in 0..right {
        repeatedString += left
    }
    return repeatedString
}


extension String {
    func length() -> Int {
        return countElements(self)
    }
}



class Column
{
    let size = 0
    
    let firstSpace = Space(size: 0)
    
    init(size: Int){
        self.size = size
        firstSpace.size = size
        
    }
    
    func addBlock( blockSize: Int) -> Bool{
        
        var last = firstSpace
        
        while (true) {
            if let b = last.next{
                last = b.next
            } else {
                break
            }
        }
        
        
        if last.size <= blockSize {
            return false
        }
        
        let lastSpace = last as Space
        
        let newSpaceSize = (firstSpace.next == nil) ? 0: 1
        
        let newLast = Space(size: last.size - blockSize - newSpaceSize)
        
        let b = Block(size: blockSize, prev: lastSpace, next: newLast)
        
        lastSpace.size = newSpaceSize
        lastSpace.next = b
        b.next = newLast
        newLast.prev = b
        
        return true
        
    }
    
    func getBlockAt(pos: Int) -> Block?{
        var last: Space = firstSpace
        var currPos = 0
        while last.next != nil {
            currPos += last.size
            
            if pos < currPos{
                break
            }
            
            let b = last.next!
            currPos += b.size
            
            if pos < currPos{
                return b
            }
            
            last = last.next!.next
        }
        return nil
        
    }
    
    
    func draw() -> String{
        var d = ""
        
        var last: Space = firstSpace
        
        while last.next != nil {
            d += last.draw()
            d += last.next!.draw()
            
            last = last.next!.next
        }
        d += last.draw()
        
        
        return d
    }
    
}


class Block: CellGroup{
    
    let size = 0
    var prev: Space
    var next: Space
    
    init(size: Int, prev: Space, next:Space){
        self.size = size
        self.next = next
        self.prev = prev
    }
    
    func draw()-> String{
        return "#" ** size
    }
    
    func moveDown() -> Bool{
        if !next.shrinkDown() {
            return false
        }
        prev.inflate()
        return true
        
    }
    
    func moveUp() -> Bool{
        if !prev.shrinkUp() {
            return false
        }
        
        next.inflate()
        return true
        
    }
    
}

class Space: CellGroup{
    
    var size = 0
    var next: Block? = nil
    var prev: Block? = nil
    
    init(let size: Int){
        self.size = size
    }
    
    func draw()-> String{
        return "_" ** size
    }
    
    func shrinkDown()-> Bool{
        if canShrink() {
            size -= 1
            return true
        }
        if let block = next {
            return block.next.shrinkDown()
        }
        return false
        
    }

    func shrinkUp()-> Bool{
        if canShrink() {
            size -= 1
            return true
        }
        if let block = prev{
            return block.prev.shrinkUp()
        }
        return false
        
    }
    
    func canShrink() -> Bool{
        return size > 1 || (size == 1 && (isLast() || isFirst()))
    }
    
    func inflate() {
        size += 1
    }
    
    func isFirst() -> Bool {
        return prev == nil
    }

    func isLast() -> Bool {
        return next == nil
    }
}

protocol CellGroup{
    
    var size: Int {get}
    
    func draw()-> String
    
}
