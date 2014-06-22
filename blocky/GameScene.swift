//
//  GameScene.swift
//  blocky
//
//  Created by Uberto Barbini on 15/06/14.
//  Copyright (c) 2014 Uberto Barbini. All rights reserved.
//

//todo
// check move with model
// update from model
// lateral numbers
// check for win

//bugs
// move block out of column

import SpriteKit

class GameScene: SKScene {
    
    let myLabel = SKLabelNode(fontNamed:"Helvetica")
    let spyLabel = SKLabelNode(fontNamed:"Helvetica")
    
    let gridModel = Grid.createNinja() //  Grid.createCatFish()

    

    
    let margin = 2
    
    var gridSize: Int = 0
    var cellSize: Int = 0
    
    var myGrid : SKShapeNode = SKShapeNode()
    
    weak var currTouch : UITouch? = nil
    weak var currBlock : SKNode? = nil
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        spyLabel.text = "start"
        spyLabel.fontSize = 12
        spyLabel.color = UIColor.whiteColor()
        spyLabel.position = CGPoint(x:100, y: 100 );
        //self.addChild(spyLabel)
        
        myGrid = createGrid()
        self.addChild(myGrid)
        
        reloadPositionsFromModel()
        
        
        myLabel.text = "Blocky!"
        myLabel.fontSize = 12
        myLabel.color = UIColor.blueColor()
        myLabel.position = CGPoint(x:CGRectGetMaxX( self.frame) * 0.9 , y: CGRectGetMaxY( self.frame) * 0.1 );
        self.addChild(myLabel)
        

    }

    
     func createGrid() -> SKShapeNode{

        let cellsForRow = gridModel.columns.count
        
        cellSize = Int(view.frame.height) / (cellsForRow + 2)
        
        gridSize = cellSize * cellsForRow
        
        let gridOffsetX = (Int(view.frame.height) - gridSize) / 2
        let gridOffsetY = (Int(view.frame.height) - gridSize) / 2
        
        myGrid = SKShapeNode(rectOfSize: CGSize(width: gridSize, height: gridSize))
        
        let gridX = CGRectGetMaxY(self.frame) / 2.0
        myGrid.position = CGPoint(x:gridX,y:gridX)
        
        var i:Int = 0
        for col in gridModel.columns{
            
            myGrid.addChild(createColumn(i, columnModel: col))
            
            i += 1
        }
        

        
        
        return myGrid
    }
    
    
    func createColumn(colNum: Int, columnModel: Column) -> SKNode{
        

        
        let column = SKShapeNode(rectOfSize: CGSize(width: cellSize - margin, height: gridSize - margin * 2))
        column.position = CGPoint(x: (colNum - columnModel.size / 2) * cellSize , y: 0)
        column.strokeColor = UIColor.grayColor()
        column.fillColor = UIColor.lightGrayColor()
        column.name = columnModel.name
        
        var space = columnModel.firstSpace
        var pos = 0
        while space.next {
            pos += space.size
            let currBlock = space.next!
            
            let block = SKShapeNode(rectOfSize: CGSize(width: cellSize - margin, height: currBlock.size * cellSize - margin ))
            block.fillColor = decideColorBySize(currBlock.size)
            block.name = currBlock.name
            column.addChild(block)
            
            space = currBlock.next
            pos += currBlock.size

            
        }

        return column
    }
    
    func convertPosToY(blockPos: Int, blockSize: Int) -> Float {
        let columnSize = gridModel.columns.count
        let ystart: Float = 0.5 * Float( columnSize * cellSize) - Float( blockPos * cellSize)
        let halfHeight : Float = Float(blockSize * cellSize) / 2.0
        return ystart - halfHeight
    }
    
   
    func reloadPositionsFromModel(){
        var i = 0
        for colM in gridModel.columns{
            
            let colV = myGrid.childNodeWithName(colM.name)
            
            var space = colM.firstSpace
            var pos = 0
            while space.next {
                pos += space.size
                let blockM = space.next!
                
                let blockV = colV.childNodeWithName(blockM.name)
                
                blockV.position = CGPoint(x: 0, y: convertPosToY( pos, blockSize: blockM.size) )
                
                space = blockM.next
                pos += blockM.size
                
                
            }

            
            i += 1
        }
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
            
            
            if let myCol = myGrid.nodeAtPoint(gridLocation) {
                let colLocation =  touch.locationInNode(myCol)
                if let myBlock = myCol.nodeAtPoint(colLocation){
                
                    if (myBlock.name?.hasPrefix("block") ){ // todo find a better way to determine SKNode kind
                        currTouch = touch as? UITouch
                        myLabel.text = "\(myBlock.name)   \(myLabel.text)"
                        currBlock = myBlock
                    } else {
                        currBlock = nil
                        myLabel.text = "not touching   \(myLabel.text)"
                    
                    }
                }
            }
            
            


            
//            let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)

  //          brick.runAction(SKAction.moveTo(CGPoint(x: brick.position.x, y:location.y) , duration: 0.3))
            
//            sprite.runAction(SKAction.repeatActionForever(action))
            
          //  self.addChild(sprite)
            
            
        }
    }
    
    
    override func touchesEnded(touches: NSSet!, withEvent event: UIEvent!){
        reloadPositionsFromModel()
    }
    
 override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
    
    for touch: AnyObject in touches {
       
        
    }
    
    if currTouch {
        if let blockV = currBlock   {
            let location = touches.anyObject().locationInNode(blockV)
        
        
            let newY = blockV.position.y + location.y
            
            let columnM = gridModel.columns[0] //todo
            
            let blockM = columnM.getBlockByName(blockV.name)!
            
            let dueY = convertPosToY(columnM.getBlockPosition( blockM.name)!, blockSize: blockM.size)
            
            if (dueY - newY) > Float(cellSize) {
                blockM.moveDown()
                
                reloadPositionsFromModel()
            } else if ( newY - dueY) > Float(cellSize) {
                blockM.moveUp()
                
                reloadPositionsFromModel()
            } else{
        
                currBlock!.position = CGPoint(x: 0, y: newY)
            }
        }
    }
    

    
 
}
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
 //       spyLabel.text = " time  " // \(currentTime.value)
    }
}
