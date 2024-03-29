//
//  GameScene.swift
//  Project 17 Space Race
//
//  Created by Rinalds Domanovs on 03/07/2019.
//  Copyright © 2019 Rinalds Domanovs. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    var starField: SKEmitterNode!
    var player: SKSpriteNode!
    var enemyCount = 0 {
        didSet {
            if enemyCount == 20 {
                decreaseEnemyInterval()
            }
        }
    }
    var enemyInterval = 1.0

    var scoreLabel: SKLabelNode!
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }

    let possibleEnemies = ["ball", "hammer", "tv"]
    var isGameOver = false
    var gameTimer: Timer?

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
        player.name = "player"
        addChild(player)

        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.position = CGPoint(x: 16, y: 16)
        scoreLabel.horizontalAlignmentMode = .left
        addChild(scoreLabel)

        score = 0

        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsWorld.contactDelegate = self

        startGameTimer()
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        var location = touch.location(in: self)

        if location.y < 100 {
            location.y = 100
        } else if location.y > 668 {
            location.y = 668
        }

        let touchNode = self.atPoint(location)

        if let name = touchNode.name {
            if name == "player" {
                player.position = location
            }
        }
    }

    func didBegin(_ contact: SKPhysicsContact) {
        let explosion = SKEmitterNode(fileNamed: "explosion")!
        explosion.position = player.position
        addChild(explosion)

        player.removeFromParent()
        gameTimer?.invalidate()

        isGameOver = true
    }

    override func update(_ currentTime: TimeInterval) {
        for node in children {
            if node.position.x < -300 {
                node.removeFromParent()
            }
        }

        if !isGameOver {
            score += 1
        }

    }

    @objc func createEnemy() {
        guard let enemy = possibleEnemies.randomElement() else { return }

        let sprite = SKSpriteNode(imageNamed: enemy)
        sprite.position = CGPoint(x: 1200, y: Int.random(in: 50...736))
        addChild(sprite)

        sprite.physicsBody = SKPhysicsBody(texture: sprite.texture!, size: sprite.size)
        sprite.physicsBody?.categoryBitMask = 1
        sprite.physicsBody?.velocity = CGVector(dx: -500, dy: 0)
        sprite.physicsBody?.angularVelocity = 5
        sprite.physicsBody?.linearDamping = 0
        sprite.physicsBody?.angularDamping = 0

        enemyCount += 1
    }

    func startGameTimer() {
        gameTimer = Timer.scheduledTimer(
            timeInterval: enemyInterval,
            target: self,
            selector: #selector(createEnemy),
            userInfo: nil,
            repeats: true)
    }

    func decreaseEnemyInterval() {
        enemyInterval -= 0.1
        enemyCount = 0
        gameTimer?.invalidate()
        startGameTimer()
    }

}
