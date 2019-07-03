//
//  GameScene.swift
//  Project 17 Space Race
//
//  Created by Rinalds Domanovs on 03/07/2019.
//  Copyright © 2019 Rinalds Domanovs. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var starField: SKEmitterNode!
    var player: SKSpriteNode!

    var scoreLabel: SKLabelNode!
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }


    override func didMove(to view: SKView) {

    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
}
