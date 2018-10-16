//
//  GameViewController.swift
//  flower
//
//  Created by Kate Roberts on 14/10/2018.
//  Copyright © 2018 Kate Roberts. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    override func viewDidLoad() {
        let scene = GameScene(size: view.frame.size)
        scene.backgroundColor = UIColor.white
        let skView = view as! SKView
        skView.presentScene(scene)
    }
}
