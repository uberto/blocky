//
//  GameScene.swift
//  blocky
//
//  Created by Uberto Barbini on 15/06/14.
//  Copyright (c) 2014 Uberto Barbini. All rights reserved.
//

//todo
// create from model
// check move with model
// update from model
// lateral numbers
// check for win

//bugs
// move column out
// move block out of column
// myLabel over grid

import SpriteKit

class GameScene: SKScene {
    
    let myLabel = SKLabelNode(fontNamed:"Helvetica")
   
    let cellSize = 50
    
    let cellsForRow = 15
    
    let margin = 2
    
    var gridSize: Int = 0
    
    var myGrid : SKShapeNode = SKShapeNode()
    
    weak var currTouch : AnyObject? = nil
    weak var currBlock : SKNode? = nil
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        
        let columnM = Column(size: cellsForRow)
        columnM.addBlock( 1)
        columnM.addBlock( 3)
        columnM.addBlock( 2)
        columnM.addBlock( 1)
        
        
        gridSize = cellSize * cellsForRow
        
        let gridOffsetX = (Int(view.frame.height) - gridSize) / 2
        let gridOffsetY = (Int(view.frame.height) - gridSize) / 2
            
        myGrid = SKShapeNode(rectOfSize: CGSize(width: gridSize, height: gridSize))
    
        
        let gridX = CGRectGetMaxY( self.frame) / 2.0
        myGrid.position = CGPoint(x:gridX,y:gridX)
        
        
        for i in 0..cellsForRow{
            myGrid.addChild(createColumn(i, columnModel: columnM))
        }
        self.addChild(myGrid)
        
        
        myLabel.text = "Blocky!"
        myLabel.fontSize = 12
        
        myLabel.position = CGPoint(x:CGRectGetMaxX( self.frame) * 0.9 , y: CGRectGetMaxY( self.frame)/2 );
        self.addChild(myLabel)
        

    }
    
    func createColumn(colNum: Int, columnModel: Column) -> SKNode{
        
        let column = SKShapeNode(rectOfSize: CGSize(width: cellSize - margin, height: gridSize - margin * 2))
        column.position = CGPoint(x: (colNum - cellsForRow / 2) * cellSize , y: 0)
        column.strokeColor = UIColor.grayColor()
        column.fillColor = UIColor.lightGrayColor()
        
        var space = columnModel.firstSpace
        var pos = 0
        while (space.next){
            pos += space.size
            let bh = space.next!.size
            
            let block = SKShapeNode(rectOfSize: CGSize(width: cellSize - margin, height: bh * cellSize - margin ))
            block.fillColor = UIColor.greenColor()
            block.name = "block \(pos) \(colNum)"
            block.position = CGPoint(x: 0, y: (pos + (bh / 2)) * cellSize )
            column.addChild(block)
            
        }

        return column
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            let gridLocation = touch.locationInNode(myGrid)
            
            myLabel.text = "\(Int(gridLocation.x))   \(Int(gridLocation.y))"
            
            
            let myCol = myGrid.nodeAtPoint(gridLocation)
            if (myCol){
                let colLocation =  touch.locationInNode(myCol)
                let myBlock = myCol.nodeAtPoint(colLocation)
                
                if (myBlock){
                   currTouch = touch
                   currBlock = myBlock
                }
                myLabel.text = "\(myBlock.name)   \(myLabel.text)"
 
            }
            
            
            
            
   //         myLabel.text = "\(Int(location.x))   \(Int(location.y))"
            
            //touch.
            
//            let sprite = SKSpriteNode(imageNamed:"Spaceship")
//            
//            sprite.xScale = 0.5
//            sprite.yScale = 0.5
//            sprite.position = location
//            
            //myLabel.position = location

            
//            let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)

  //          brick.runAction(SKAction.moveTo(CGPoint(x: brick.position.x, y:location.y) , duration: 0.3))
            
//            sprite.runAction(SKAction.repeatActionForever(action))
            
          //  self.addChild(sprite)
            
            
        }
    }
    
    
    override func touchesEnded(touches: NSSet!, withEvent event: UIEvent!){
        
    }
    
 override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
    
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
    
 //           brick.position = CGPoint(x: brick.position.x, y:location.y)
      
        }
    
    if (currTouch){
        let location = touches.anyObject().locationInNode(currBlock)
        currBlock!.position = CGPoint(x: 0, y: currBlock!.position.y + location.y)
    }
}
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
