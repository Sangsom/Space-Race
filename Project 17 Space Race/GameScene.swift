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
        backgroundColor = .black

        starField = SKEmitterNode(fileNamed: "starfield")!
        starField.position = CGPoint(x: 1024, y: 384)
        starField.advanceSimulationTime(10)
        addChild(starField)
        starField.zPosition = -1

        player = SKSpriteNode(imageNamed: "player")
        player.position = CGPoint(x: 100, y: 384)
        player.physicsBody = SKPhysicsBody(texture: player.texture!, size: player.size)
        player.physicsBody?.contactTestBitMask = 1
        addChild(player)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
}
