//
//  GameScene.swift
//  flower
//
//  Created by Kate Roberts on 14/10/2018.
//  Copyright © 2018 Kate Roberts. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    //let label = SKLabelNode(text:"Hello")
    let days_used_data = [true, true, true, true, true, true, true]
    
    /// flower111111111
    /// flower100111111
    /// filename =  string(flower) + "1" +"0"
    
    let stalk = SKSpriteNode(imageNamed: "tempStalk")
    let centre = SKSpriteNode(imageNamed: "tempCentre")
    let petal1 = SKSpriteNode(imageNamed: "tempPetal")
    let petal2 = SKSpriteNode(imageNamed: "tempPetal")
    let petal3 = SKSpriteNode(imageNamed: "tempPetal")
    let petal4 = SKSpriteNode(imageNamed: "tempPetal")
    let petal5 = SKSpriteNode(imageNamed: "tempPetal")
    let petal6 = SKSpriteNode(imageNamed: "tempPetal")
    let petal7 = SKSpriteNode(imageNamed: "tempPetal")
    
    
    override func didMove(to view: SKView) {
       // using numbers is not a good way of setting the position, because it will mess up on different sized screens
        stalk.position = CGPoint(x: frame.midX, y:frame.midY*0.6)
        centre.position = CGPoint(x: frame.midX+37, y:frame.midY*0.5)
        petal1.position = CGPoint(x: frame.midX+37, y:frame.midY)
        petal2.position = CGPoint(x: frame.midX+37, y:frame.midY)
        petal3.position = CGPoint(x: frame.midX+37, y:frame.midY)
        petal4.position = CGPoint(x: frame.midX+37, y:frame.midY)
        petal5.position = CGPoint(x: frame.midX+37, y:frame.midY)
        petal6.position = CGPoint(x: frame.midX+37, y:frame.midY)
        petal7.position = CGPoint(x: frame.midX+37, y:frame.midY)
        
        stalk.setScale(4.0)
        centre.setScale(4.0)
        petal1.setScale(4.0)
        petal2.setScale(4.0)
        petal3.setScale(4.0)
        petal4.setScale(4.0)
        petal5.setScale(4.0)
        petal6.setScale(4.0)
        petal7.setScale(4.0)
        
        petal2.colorBlendFactor = 0.8
        petal3.colorBlendFactor = 0.7
        petal4.colorBlendFactor = 0.6
        petal5.colorBlendFactor = 0.5
        petal6.colorBlendFactor = 0.4
        petal7.colorBlendFactor = 0.3
        
        self.addChild(stalk)
        self.addChild(centre)
        
        petal2.zRotation = .pi/3.5
        petal3.zRotation = 2*(.pi/3.5)
        petal4.zRotation = 3*(.pi/3.5)
        petal5.zRotation = 4*(.pi/3.5)
        petal6.zRotation = 5*(.pi/3.5)
        petal7.zRotation = 6*(.pi/3.5)
        
        self.addChild(petal1)
        ///self.addChild(petal2)
        ///self.addChild(petal3)
        self.addChild(petal4)
        self.addChild(petal5)
        self.addChild(petal6)
        self.addChild(petal7)
    }
    
    
}
