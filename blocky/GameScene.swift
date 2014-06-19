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

    let brick = SKShapeNode(rectOfSize: CGSize(width: 50, height: 30))

    let myGrid = SKShapeNode(rectOfSize: CGSize(width: 750, height: 750))

    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        myLabel.text = "Blocky!"
        myLabel.fontSize = 24
        
        myLabel.position = CGPoint(x:CGRectGetMaxX( self.frame)/2 , y: CGRectGetMaxY( self.frame)/2 ); //-   myLabel.frame.height
        
        brick.fillColor = UIColor.blueColor()
        brick.position = CGPoint(x:100, y:100)

        let gridX = CGRectGetMaxY( self.frame) / 2.0
        
        
        myGrid.position = CGPoint(x:gridX,y:gridX)
        
        self.addChild(brick)
        
        self.addChild(myLabel)
        
        self.addChild(myGrid)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            
//            let sprite = SKSpriteNode(imageNamed:"Spaceship")
//            
//            sprite.xScale = 0.5
//            sprite.yScale = 0.5
//            sprite.position = location
//            
            //myLabel.position = location
            myLabel.text = "\(Int(location.x))   \(Int(location.y))"
            
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
    
            brick.position = CGPoint(x: brick.position.x, y:location.y)
      
        }
}
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
