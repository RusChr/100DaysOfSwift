//
//  GameScene.swift
//  Project11
//
//  Created by Rustam Chergizbiev on 9/17/22.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
	
	var scoreLabel: SKLabelNode!
	var editLabel: SKLabelNode!
	
	var balls = [String]()
	
	var score = 0 {
		didSet {
			scoreLabel.text = "Score: \(score)"
		}
	}
	
	var editingMode: Bool = false {
		didSet {
			editLabel.text = editingMode ? "Done" : "Edit"
		}
	}
	
    
	override func didMove(to view: SKView) {
		
		loadBalls()
		
		let background = SKSpriteNode(imageNamed: "background.jpg")
		background.position = CGPoint(x: 512, y: 384)
		background.blendMode = .replace
		background.zPosition = -1
		physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
		physicsWorld.contactDelegate = self
		addChild(background)
		
		makeSlot(at: CGPoint(x: 128, y: 0), isGood: true)
		makeSlot(at: CGPoint(x: 384, y: 0), isGood: false)
		makeSlot(at: CGPoint(x: 640, y: 0), isGood: true)
		makeSlot(at: CGPoint(x: 896, y: 0), isGood: false)
		
		makeBouncer(at: CGPoint(x: 0, y: 0))
		makeBouncer(at: CGPoint(x: 256, y: 0))
		makeBouncer(at: CGPoint(x: 512, y: 0))
		makeBouncer(at: CGPoint(x: 768, y: 0))
		makeBouncer(at: CGPoint(x: 1024, y: 0))
		
		scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
		scoreLabel.text = "Score: 0"
		scoreLabel.horizontalAlignmentMode = .right
		scoreLabel.position = CGPoint(x: 980, y: 700)
		addChild(scoreLabel)
		
		editLabel = SKLabelNode(fontNamed: "Chalkduster")
		editLabel.text = "Edit"
		editLabel.position = CGPoint(x: 80, y: 700)
		addChild(editLabel)
	}
	
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		if let touch = touches.first {
			let location = touch.location(in: self)
//			let box = SKSpriteNode(color: UIColor.red, size: CGSize(width: 64, height: 64))
//			box.position = location
//			box.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 64, height: 64))
//			addChild(box)
			
			let objects = nodes(at: location)
			
			if objects.contains(editLabel) {
				editingMode.toggle()
			} else {
				if editingMode {
					let size = CGSize(width: Int.random(in: 16...128), height: 16)
					let box = SKSpriteNode(color: UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1), size: size)
					
					box.zRotation = CGFloat.random(in: 0...3)
					box.position = location
					box.physicsBody = SKPhysicsBody(rectangleOf: box.size)
					box.physicsBody?.isDynamic = false
					addChild(box)
					
				} else {
					let ball = SKSpriteNode(imageNamed: getRandomBall())
					ball.name = "ball"
					ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2.0)
					ball.physicsBody?.restitution = 0.999
					ball.physicsBody!.contactTestBitMask = ball.physicsBody!.collisionBitMask
					ball.position = CGPoint(x: location.x, y: 700)
					addChild(ball)
				}
			}
		}
	}
	
	
	func makeBouncer(at position: CGPoint) {
		let bouncer = SKSpriteNode(imageNamed: "bouncer")
		bouncer.position = position
		bouncer.physicsBody = SKPhysicsBody(circleOfRadius: bouncer.size.width / 2.0)
		bouncer.physicsBody?.isDynamic = false
		addChild(bouncer)
	}
	
	
	func makeSlot(at position: CGPoint, isGood: Bool) {
		var slotBase: SKSpriteNode
		var slotGlow: SKSpriteNode
		
		if isGood {
			slotBase = SKSpriteNode(imageNamed: "slotBaseGood")
			slotGlow = SKSpriteNode(imageNamed: "slotGlowGood")
			slotBase.name = "good"
		} else {
			slotBase = SKSpriteNode(imageNamed: "slotBaseBad")
			slotGlow = SKSpriteNode(imageNamed: "slotGlowBad")
			slotBase.name = "bad"
		}
		
		
		slotBase.position = position
		slotGlow.position = position
		
		let spin = SKAction.rotate(byAngle: .pi, duration: 10)
		let spinForever = SKAction.repeatForever(spin)
		slotGlow.run(spinForever)
		
		slotBase.physicsBody = SKPhysicsBody(rectangleOf: slotBase.size)
		slotBase.physicsBody?.isDynamic = false
		
		addChild(slotBase)
		addChild(slotGlow)
	}
	
	
	func collisionBetween(ball: SKNode, object: SKNode) {
		if object.name == "good" {
			destroy(ball: ball)
			score += 1
		} else if object.name == "bad" {
			destroy(ball: ball)
			score -= 1
		}
	}
	
	
	func destroy(ball: SKNode) {
		if let fireParticles = SKEmitterNode(fileNamed: "FireParticles"), let smokeParticles = SKEmitterNode(fileNamed: "SmokeParticles") {
			fireParticles.position = ball.position
			smokeParticles.position = ball.position
			addChild(fireParticles)
			addChild(smokeParticles)
		}
		
		ball.removeFromParent()
	}
	
	
	func didBegin(_ contact: SKPhysicsContact) {
		guard let nodeA = contact.bodyA.node, let nodeB = contact.bodyB.node else { return }
		
		if nodeA.name == "ball" {
			collisionBetween(ball: nodeA, object: nodeB)
		} else if nodeB.name == "ball" {
			collisionBetween(ball: nodeB, object: nodeA)
		}
	}
	
	
	func getRandomBall() -> String {
		return balls.randomElement() ?? "redBall"
	}
	
	
	func loadBalls() {
		let fm = FileManager.default
		let path = Bundle.main.resourcePath!
		let items = try! fm.contentsOfDirectory(atPath: path)
		
		for item in items {
			if item.hasPrefix("ball") {
				balls.append(item)
			}
		}
	}
}
