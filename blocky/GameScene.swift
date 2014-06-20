//
//  GameScene.swift
//  blocky
//
//  Created by Uberto Barbini on 15/06/14.
//  Copyright (c) 2014 Uberto Barbini. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    let myLabel = SKLabelNode(fontNamed:"Helvetica")

   // let brick = SKShapeNode(rectOfSize: CGSize(width: 50, height: 30))
    
    let cellSize = 50
    
    let cellsForRow = 15
    
    let margin = 2
    
    var gridSize: Int = 0
    
    var myGrid : SKShapeNode = SKShapeNode()
    
    weak var currTouch : AnyObject? = nil
    weak var currBlock : SKNode? = nil
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */

        
        gridSize = cellSize * cellsForRow
        
        let gridOffsetX = (Int(view.frame.height) - gridSize) / 2
        let gridOffsetY = (Int(view.frame.height) - gridSize) / 2
            
        myGrid = SKShapeNode(rectOfSize: CGSize(width: gridSize, height: gridSize))
    
        
        let gridX = CGRectGetMaxY( self.frame) / 2.0
        myGrid.position = CGPoint(x:gridX,y:gridX)
        
        
        
        
        for i in 0..cellsForRow{
            let column = SKShapeNode(rectOfSize: CGSize(width: cellSize - margin, height: gridSize - margin * 2))
            column.position = CGPoint(x: (i - cellsForRow / 2) * cellSize , y: 0)
            column.strokeColor = UIColor.grayColor()
            
            
            
            column.fillColor = UIColor.lightGrayColor()
            myGrid.addChild(column)
            
            let b1 = SKShapeNode(rectOfSize: CGSize(width: cellSize - margin, height: cellSize - margin ))
            b1.fillColor = UIColor.greenColor()
            b1.name = "block 1 \(i)"
            b1.position = CGPoint(x: 0, y: Int(arc4random_uniform(600)))
            column.addChild(b1)
            
            
            let b2 = SKShapeNode(rectOfSize: CGSize(width: cellSize - margin, height: 2 * cellSize - margin ))
            b2.fillColor = UIColor.redColor()
            b2.name = "block 2 \(i)"
                b2.position = CGPoint(x: 0, y: Int(arc4random_uniform(600)))
                    column.addChild(b2)
            
            let b3 = SKShapeNode(rectOfSize: CGSize(width: cellSize - margin, height: 3 * cellSize - margin ))
            b3.fillColor = UIColor.magentaColor()
            b3.name = "block 3 \(i)"
                    b3.position = CGPoint(x: 0, y: Int(arc4random_uniform(600)))
                        column.addChild(b3)
            
            
            
        }
        self.addChild(myGrid)
        
        
        
        
        myLabel.text = "Blocky!"
        myLabel.fontSize = 24
        
        myLabel.position = CGPoint(x:CGRectGetMaxX( self.frame) * 0.6 , y: CGRectGetMaxY( self.frame)/2 ); //-   myLabel.frame.height
        
        self.addChild(myLabel)
        

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
