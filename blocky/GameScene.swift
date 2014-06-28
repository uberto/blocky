//
//  GameScene.swift
//  blocky
//
//  Created by Uberto Barbini on 15/06/14.
//  Copyright (c) 2014 Uberto Barbini. All rights reserved.
//

//todo
// lateral numbers green when ok
// touch state as separate obj
// callback to refresh
// better coord translations
// check for win
// animation for solved

//bugs
// block should go to next position from nearby, better rounding
// no block over grid limits


import SpriteKit

class GameScene: SKScene {
    
    let myLabel = SKLabelNode(fontNamed:"Helvetica")
    let spyLabel = SKLabelNode(fontNamed:"Helvetica")
    
    let gridModel = Grid.createCatFish()
   // let gridModel = Grid.createNinja()
    

    
    let margin = 2
    
    var gridSize: Int = 0
    var cellSize: Int = 0
    
    var myGrid : SKShapeNode = SKShapeNode()
    
    
    //todo move touch state in dedicated object
    weak var currTouch : UITouch? = nil
    var currBlock : SKNode? = nil
    var currColName = ""
    var touchOffsetY : Float = 0
    
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
            
            myGrid.addChild(createLabel(i))

            i += 1
        }
        

        
        
        return myGrid
    }
    
    func createLabel(row: Int) -> SKLabelNode {
        let label = SKLabelNode(fontNamed:"Courier")
        
        label.text = gridModel.rowHints[row].description()
        label.fontSize = 14
        label.color = UIColor.blackColor()
        label.verticalAlignmentMode = SKLabelVerticalAlignmentMode.Center
        label.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left

        label.position = CGPoint(x: gridSize / 2 + cellSize / 5  , y: row * cellSize - gridSize / 2 + cellSize / 2 )
        
        return label
    }
    
    func createColumn(colNum: Int, columnModel: Column) -> SKNode{
        

        
        let column = SKShapeNode(rectOfSize: CGSize(width: cellSize - margin, height: gridSize - margin * 2))
        column.position = CGPoint(x: (colNum - columnModel.size / 2) * cellSize , y: 0)
        column.strokeColor = UIColor.grayColor()
        column.fillColor = UIColor.lightGrayColor()
        column.name = columnModel.name
        column.antialiased = false
        
        var space = columnModel.firstSpace
        var pos = 0
        while space.next {
            pos += space.size
            let currBlock = space.next!
            
            let block = SKShapeNode(rectOfSize: CGSize(width: cellSize - margin, height: currBlock.size * cellSize - margin ))
            block.fillColor = decideColorBySize(currBlock.size)
            block.name = currBlock.name
            block.antialiased = false
            
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

        let baseColor = 1.0 - (Float(size) / Float(gridModel.columns.count))
        
        switch size % 7 {

            case 1:
               return UIColor(hue: 0.3, saturation: 0.8, brightness: baseColor, alpha: 1)
            case 2:
               return UIColor(hue: 0.6, saturation: 0.8, brightness: baseColor, alpha: 1)
            case 3:
               return UIColor(hue: 0.9, saturation: 0.8, brightness: baseColor, alpha: 1)
            case 4:
               return UIColor(hue: 0.2, saturation: 0.8, brightness: baseColor, alpha: 1)
            case 5:
               return UIColor(hue: 0.5, saturation: 0.8, brightness: baseColor, alpha: 1)
            case 6:
               return UIColor(hue: 0.8, saturation: 0.8, brightness: baseColor, alpha: 1)
            default:
               return UIColor(hue: 0.05, saturation: 0.8, brightness: baseColor, alpha: 1)
      
     

        }
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            let gridLocation = touch.locationInNode(myGrid)
            
            myLabel.text = "\(Int(gridLocation.x))   \(Int(gridLocation.y))"
            
            
            if let myCol = myGrid.nodeAtPoint(gridLocation) { //todo actuall mycol is a block if touch the block
                let colLocation =  touch.locationInNode(myCol)
                if let myBlock = myCol.nodeAtPoint(colLocation){
                
                    if (myBlock.name?.hasPrefix("block") ){ // todo find a better way to determine SKNode kind
                        currTouch = touch as? UITouch
                        myLabel.text = "\(myBlock.name)   \(myLabel.text)"
                        currBlock = myBlock
                        currColName = myBlock.parent.name
                        touchOffsetY = touch.locationInNode(myBlock).y
                    } else {
                        currBlock = nil
                        myLabel.text = "not touching   \(myLabel.text)"
                    currColName = ""
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
    
    let halfCell = Float(cellSize) / 2
    
    for touch: AnyObject in touches {
        if let touch = currTouch {
            if let blockV = currBlock   {
                //   let touch = touches.anyObject()
                let location = touch.locationInNode(blockV)
                
                let newY = blockV.position.y + location.y - touchOffsetY
                
                let columnM = gridModel.getColumnByName(currColName)!
                
                let blockM = columnM.getBlockByName(blockV.name)!
                
                let dueY = convertPosToY(columnM.getBlockPosition( blockM.name)!, blockSize: blockM.size)
                
                if (dueY - newY ) > halfCell {
                    if blockM.moveDown(){
                    
                        reloadPositionsFromModel()
                        blockV.position = CGPoint(x: 0, y: newY)
                    }
                    
                } else if ( newY - dueY) > halfCell {
                    if blockM.moveUp() {
                    
                        reloadPositionsFromModel()
                        blockV.position = CGPoint(x: 0, y: newY)
                    }
                } else{
                    
                    blockV.position = CGPoint(x: 0, y: newY)
                }
            }
        }
    }
    
 
}
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
 //       spyLabel.text = " time  " // \(currentTime.value)
    }
}
