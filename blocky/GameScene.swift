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
    let spyLabel = SKLabelNode(fontNamed:"Helvetica")
    
    let cellSize = 50
    
    let cellsForRow = 15
    
    let margin = 2
    
    var gridSize: Int = 0
    
    var myGrid : SKShapeNode = SKShapeNode()
    
    weak var currTouch : AnyObject? = nil
    weak var currBlock : SKNode? = nil
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        spyLabel.text = "start"
        spyLabel.fontSize = 12
        spyLabel.color = UIColor.whiteColor()
        spyLabel.position = CGPoint(x:100, y: 100 );
        self.addChild(spyLabel)
        
        myGrid = createGrid()
        self.addChild(myGrid)
        
        
        myLabel.text = "Blocky!"
        myLabel.fontSize = 12
        myLabel.color = UIColor.blueColor()
        myLabel.position = CGPoint(x:CGRectGetMaxX( self.frame) * 0.9 , y: CGRectGetMaxY( self.frame) * 0.1 );
        self.addChild(myLabel)
        

    }

    
    func createGrid() -> SKShapeNode{
        let columnM = Column(size: cellsForRow)
        columnM.addBlock( 1)
        columnM.addBlock( 3)
        columnM.addBlock( 2)
        columnM.addBlock( 1)
        
        let grid = Grid.createCatFish()
        
        gridSize = cellSize * cellsForRow
        
        let gridOffsetX = (Int(view.frame.height) - gridSize) / 2
        let gridOffsetY = (Int(view.frame.height) - gridSize) / 2
        
        myGrid = SKShapeNode(rectOfSize: CGSize(width: gridSize, height: gridSize))
        
        
        let gridX = CGRectGetMaxY( self.frame) / 2.0
        myGrid.position = CGPoint(x:gridX,y:gridX)
        
        
        for i in 0..cellsForRow{
            myGrid.addChild(createColumn(i, columnModel: grid.columns[i]))
        }
        
        return myGrid
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
            let currBlock = space.next!
            
            let block = SKShapeNode(rectOfSize: CGSize(width: cellSize - margin, height: currBlock.size * cellSize - margin ))
            block.fillColor = decideColorBySize(currBlock.size)
            block.name = "block \(pos) \(colNum)"
            block.position = CGPoint(x: 0, y: pos * cellSize + currBlock.size * cellSize / 2 )
            column.addChild(block)
            
            space = currBlock.next
            pos += currBlock.size
            
            
        }

        return column
    }
    
    
    func decideColorBySize(size: Int) -> UIColor {
        switch size {
            case 1:
                return UIColor.redColor()
            case 2:
                return UIColor.greenColor()
            case 3:
                return UIColor.magentaColor()
            case 4:
                return UIColor.cyanColor()
            case 5:
                return UIColor.blueColor()
            default:
                return UIColor.whiteColor()

        }
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
                
                if (myBlock.name){ //cols has no name  todo find a better way to determine SKNode kind
                   currTouch = touch
                    myLabel.text = "\(myBlock.name)   \(myLabel.text)"
                    currBlock = myBlock
                } else {
                    currBlock = nil
                    myLabel.text = "not touching   \(myLabel.text)"
                    
                }
            }
            
            


            
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
       
        
    }
    
    if (currTouch  && currBlock){
        let location = touches.anyObject().locationInNode(currBlock)
        currBlock!.position = CGPoint(x: 0, y: currBlock!.position.y + location.y)
    }
    

    
 
}
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
 //       spyLabel.text = " time  " // \(currentTime.value)
    }
}
