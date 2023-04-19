import SwiftUI
import SpriteKit

class BimaScene: SKScene{
    let bimaNode: BimaNode = BimaNode()
    let shadowBima: BimaNode = BimaNode()
    var previousTouch: CGPoint?
    
    @ObservedObject var dataWayang: DataWayang
    
    
    init(size: CGSize, dataWayang: DataWayang) {
        self.dataWayang = dataWayang
        super.init(size: size)
        self.addChild(bimaNode)
        if dataWayang.showBimaDesc == false {
            self.addChild(shadowBima)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        self.backgroundColor = .clear
        
        if dataWayang.showBimaDesc == false {
            shadowBima.position = .init(x: 150, y: 125)
            shadowBima.zPosition = -2
            
            configShadow(bimaNode: shadowBima)
        }
        
        bimaNode.position = .init(x: 125, y: 125)
        configPhysics(bimaNode: bimaNode)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        let previousLocation = touch.previousLocation(in: self)
        let touchedNodes = nodes(at: touchLocation)
        
        for node in touchedNodes {
            
            
            let radius = bimaNode.rightRange.frame.width/4
            if dataWayang.showBimaDesc == false{
                if node.name == "BimaRightStick"{
                    let distance = hypot(bimaNode.rightHand.position.x - bimaNode.rightRange.position.x, bimaNode.rightHand.position.y - bimaNode.rightRange.position.y)
                    if distance <= radius {
                        node.position = CGPoint(x: node.position.x + touchLocation.x - previousLocation.x, y: node.position.y + touchLocation.y - previousLocation.y)
                    }else{
                        node.position = CGPoint(x: node.position.x + (bimaNode.rightRange.position.x - bimaNode.rightHand.position.x < 0 ? -1 : 1), y: node.position.y + (bimaNode.rightRange.position.y - bimaNode.rightHand.position.y < 0 ? -1 : 1))
                    }
                }else if node.name == "BimaLeftStick" {
                    let distance = hypot(bimaNode.leftHand.position.x - bimaNode.leftRange.position.x, bimaNode.leftHand.position.y - bimaNode.leftRange.position.y)
                    if distance <= radius {
                        node.position = CGPoint(x: node.position.x + touchLocation.x - previousLocation.x, y: node.position.y + touchLocation.y - previousLocation.y)
                    }else{
                        node.position = CGPoint(x: node.position.x + (bimaNode.leftRange.position.x - bimaNode.leftHand.position.x < 0 ? -1 : 1), y: node.position.y + (bimaNode.leftRange.position.y - bimaNode.leftHand.position.y < 0 ? -1 : 1))
                    }
                }
                
                
                if  node.name == "BimaStickBody" && (120...165).contains(touchLocation.x) {
                    bimaNode.position.x =  touchLocation.x
                    
                }
            }
            previousTouch = touchLocation
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        previousTouch = nil
        let difficulty = 0.75
        let duration = 1.0
        var ctr = 0
        if ((shadowBima.position.x - difficulty ... shadowBima.position.x + difficulty).contains(bimaNode.position.x)){
            
            let moveAction = SKAction.move(to: shadowBima.position, duration: duration)
            bimaNode.run(moveAction)
            bimaNode.stickBody.isHidden = true
            ctr += 1
        }
        
        if((shadowBima.leftHand.position.x - difficulty ... shadowBima.leftHand.position.x + difficulty).contains(bimaNode.leftHand.position.x) && (shadowBima.leftArm.position.x - difficulty ... shadowBima.leftArm.position.x + difficulty).contains(bimaNode.leftArm.position.x) && (shadowBima.leftHand.zRotation - difficulty ... shadowBima.leftHand.zRotation + difficulty).contains(bimaNode.leftHand.zRotation) && (shadowBima.leftArm.zRotation - difficulty ... shadowBima.leftArm.zRotation + difficulty).contains(bimaNode.leftArm.zRotation)){
            let moveAction = SKAction.move(to: shadowBima.leftStick.position, duration: duration)
            bimaNode.leftStick.run(moveAction)
            bimaNode.leftStick.isHidden = true
            ctr += 1
        }
        
        if((shadowBima.rightHand.position.x - difficulty ... shadowBima.rightHand.position.x + difficulty).contains(bimaNode.rightHand.position.x) && (shadowBima.rightArm.position.x - difficulty ... shadowBima.rightArm.position.x + difficulty).contains(bimaNode.rightArm.position.x) && (shadowBima.rightHand.zRotation - difficulty ... shadowBima.rightHand.zRotation + difficulty).contains(bimaNode.rightHand.zRotation) && (shadowBima.rightArm.zRotation - difficulty ... shadowBima.rightArm.zRotation + difficulty).contains(bimaNode.rightArm.zRotation)){
            let moveAction = SKAction.move(to: shadowBima.rightStick.position, duration: duration)
            bimaNode.rightStick.run(moveAction)
            bimaNode.rightStick.isHidden = true
            ctr += 1
        }
        
        if ctr == 3 {
            let delay = SKAction.wait(forDuration: 2.5)
            let hideAction = SKAction.hide()
            let sequence = SKAction.sequence([delay, hideAction])
            shadowBima.run(sequence)
            dataWayang.showBimaDesc = true
        }
        
    }
    
    
    private func configPhysics(bimaNode: BimaNode){
        
        let bodyPhysics = SKPhysicsBody(rectangleOf: bimaNode.body.size)
        bodyPhysics.affectedByGravity = false
        bodyPhysics.collisionBitMask = 0
        bodyPhysics.contactTestBitMask = 0x1 << 1
        bodyPhysics.categoryBitMask = 0x1 << 6
        bimaNode.body.physicsBody = bodyPhysics
        
        let rightArmPhysics = SKPhysicsBody(rectangleOf: bimaNode.rightArm?.size ?? .zero)
        rightArmPhysics.allowsRotation = true
        rightArmPhysics.affectedByGravity = false
        rightArmPhysics.collisionBitMask = 0
        rightArmPhysics.contactTestBitMask = 0x1 << 2
        rightArmPhysics.categoryBitMask = 0x1 << 7
        rightArmPhysics.density = 2
        bimaNode.rightArm.physicsBody = rightArmPhysics
        
        let rightHandPhysics = SKPhysicsBody(rectangleOf: bimaNode.rightHand?.size ?? .zero)
        rightHandPhysics.allowsRotation = true
        rightHandPhysics.affectedByGravity = false
        rightHandPhysics.collisionBitMask = 0
        rightHandPhysics.contactTestBitMask = 0x1 << 3
        rightHandPhysics.categoryBitMask = 0x1 << 8
        rightHandPhysics.density = 2
        bimaNode.rightHand.physicsBody = rightHandPhysics
        
        
        let leftArmPhysics = SKPhysicsBody(rectangleOf: bimaNode.leftArm?.size ?? .zero)
        leftArmPhysics.allowsRotation = true
        leftArmPhysics.affectedByGravity = false
        leftArmPhysics.collisionBitMask = 0
        leftArmPhysics.contactTestBitMask =  0x1 << 2
        leftArmPhysics.categoryBitMask = 0x1 << 7
        bimaNode.leftArm.physicsBody = leftArmPhysics
        
        let leftHandPhysics = SKPhysicsBody(rectangleOf: bimaNode.leftArm?.size ?? .zero)
        leftHandPhysics.allowsRotation = true
        leftHandPhysics.affectedByGravity = false
        leftHandPhysics.collisionBitMask = 0
        leftHandPhysics.contactTestBitMask = 0x1 << 3
        leftHandPhysics.categoryBitMask = 0x1 << 8
        leftHandPhysics.density = 2
        bimaNode.leftHand.physicsBody = leftHandPhysics
        
        
        let rightArmJoint: SKPhysicsJointPin = SKPhysicsJointPin.joint(
            withBodyA: rightArmPhysics,
            bodyB: bodyPhysics,
            anchor: .init(
                x: bimaNode.position.x + bimaNode.body.size.width / 2 - 4,
                y: bimaNode.position.y + bimaNode.body.size.height / 5.5 - 2)
        )
        
        let rightHandJoint: SKPhysicsJointPin = SKPhysicsJointPin.joint(
            withBodyA: rightArmPhysics,
            bodyB: rightHandPhysics,
            anchor: .init(
                x: bimaNode.position.x + bimaNode.body.size.width / 2 - 4,
                y: bimaNode.position.y - 6.5
            )
        )
        
        let leftArmJoint: SKPhysicsJointPin = SKPhysicsJointPin.joint(
            withBodyA: leftArmPhysics,
            bodyB: bodyPhysics,
            anchor: .init(
                x: bimaNode.position.x  - bimaNode.body.size.width / 4,
                y: bimaNode.position.y + bimaNode.body.size.height / 5.5 - 2)
        )
        
        let leftHandJoint: SKPhysicsJointPin = SKPhysicsJointPin.joint(
            withBodyA: leftArmPhysics,
            bodyB: leftHandPhysics,
            anchor: .init(
                x: bimaNode.position.x - bimaNode.body.size.width / 4,
                y: bimaNode.position.y - 6.5)
        )
        
        let stickBody: SKPhysicsJointFixed = SKPhysicsJointFixed.joint(
            withBodyA: bodyPhysics,
            bodyB: bimaNode.stickBody.physicsBody!,
            anchor: .init(
                x: bimaNode.position.x,
                y: bimaNode.position.y)
        )
        self.physicsWorld.add(stickBody)
        
        let leftStick: SKPhysicsJointPin = SKPhysicsJointPin.joint(
            withBodyA: bimaNode.leftStick.physicsBody!,
            bodyB: leftHandPhysics,
            anchor: .init(
                x: bimaNode.position.x  - bimaNode.body.size.width / 4,
                y: bimaNode.position.y/1.65)
        )
        self.physicsWorld.add(leftStick)
        
        let rightStick: SKPhysicsJointPin = SKPhysicsJointPin.joint(
            withBodyA: bimaNode.rightStick.physicsBody!,
            bodyB: rightHandPhysics,
            anchor: .init(
                x: bimaNode.position.x + bimaNode.body.size.width / 2 - 4,
                y: bimaNode.position.y/1.65)
        )
        self.physicsWorld.add(rightStick)
        
        
        self.physicsWorld.add(rightArmJoint)
        self.physicsWorld.add(leftArmJoint)
        self.physicsWorld.add(rightHandJoint)
        self.physicsWorld.add(leftHandJoint)
    }
    
    
    
    
    private func configShadow(bimaNode: BimaNode){
        let bodyPhysics = SKPhysicsBody(rectangleOf: bimaNode.body.size)
        bodyPhysics.affectedByGravity = false
        bodyPhysics.collisionBitMask = 0
        bodyPhysics.contactTestBitMask = 0x1 << 6
        bodyPhysics.categoryBitMask = 0x1 << 1
        bimaNode.body.physicsBody = bodyPhysics
        
        let rightArmPhysics = SKPhysicsBody(rectangleOf: bimaNode.rightArm?.size ?? .zero)
        rightArmPhysics.allowsRotation = true
        rightArmPhysics.affectedByGravity = false
        bimaNode.rightArm.physicsBody = rightArmPhysics
        rightArmPhysics.collisionBitMask = 0
        rightArmPhysics.contactTestBitMask = 0x1 << 7
        rightArmPhysics.categoryBitMask = 0x1 << 2
        rightArmPhysics.density = 2
        
        let rightHandPhysics = SKPhysicsBody(rectangleOf: bimaNode.rightHand?.size ?? .zero)
        rightHandPhysics.allowsRotation = true
        rightHandPhysics.affectedByGravity = false
        rightHandPhysics.collisionBitMask = 0
        rightHandPhysics.contactTestBitMask = 0x1 << 8
        rightHandPhysics.categoryBitMask = 0x1 << 3
        rightHandPhysics.density = 2
        bimaNode.rightHand.physicsBody = rightHandPhysics
        
        
        let leftArmPhysics = SKPhysicsBody(rectangleOf: bimaNode.leftArm?.size ?? .zero)
        leftArmPhysics.allowsRotation = true
        leftArmPhysics.affectedByGravity = false
        leftArmPhysics.collisionBitMask = 0
        leftArmPhysics.contactTestBitMask = 0x1 << 7
        leftArmPhysics.categoryBitMask = 0x1 << 2
        bimaNode.leftArm.physicsBody = leftArmPhysics
        
        let leftHandPhysics = SKPhysicsBody(rectangleOf: bimaNode.leftArm?.size ?? .zero)
        leftHandPhysics.allowsRotation = true
        leftHandPhysics.affectedByGravity = false
        leftHandPhysics.collisionBitMask = 0
        leftHandPhysics.contactTestBitMask = 0x1 << 8
        leftHandPhysics.categoryBitMask = 0x1 << 3
        leftHandPhysics.density = 2
        bimaNode.leftHand.physicsBody = leftHandPhysics
        
        
        let rightArmJoint: SKPhysicsJointPin = SKPhysicsJointPin.joint(
            withBodyA: rightArmPhysics,
            bodyB: bodyPhysics,
            anchor: .init(
                x: bimaNode.position.x + bimaNode.body.size.width / 2 - 4,
                y: bimaNode.position.y + bimaNode.body.size.height / 5.5 - 2)
        )
        
        let rightHandJoint: SKPhysicsJointPin = SKPhysicsJointPin.joint(
            withBodyA: rightArmPhysics,
            bodyB: rightHandPhysics,
            anchor: .init(
                x: bimaNode.position.x + bimaNode.body.size.width / 2 - 4,
                y: bimaNode.position.y - 6.5
            )
        )
        
        let leftArmJoint: SKPhysicsJointPin = SKPhysicsJointPin.joint(
            withBodyA: leftArmPhysics,
            bodyB: bodyPhysics,
            anchor: .init(
                x: bimaNode.position.x  - bimaNode.body.size.width / 4,
                y: bimaNode.position.y + bimaNode.body.size.height / 5.5 - 2)
        )
        
        let leftHandJoint: SKPhysicsJointPin = SKPhysicsJointPin.joint(
            withBodyA: leftArmPhysics,
            bodyB: leftHandPhysics,
            anchor: .init(
                x: bimaNode.position.x - bimaNode.body.size.width / 4,
                y: bimaNode.position.y - 6.5)
        )
        
        let stickBody: SKPhysicsJointFixed = SKPhysicsJointFixed.joint(
            withBodyA: bodyPhysics,
            bodyB: bimaNode.stickBody.physicsBody!,
            anchor: .init(
                x: bimaNode.position.x,
                y: bimaNode.position.y)
        )
        self.physicsWorld.add(stickBody)
        
        let leftStick: SKPhysicsJointPin = SKPhysicsJointPin.joint(
            withBodyA: bimaNode.leftStick.physicsBody!,
            bodyB: leftHandPhysics,
            anchor: .init(
                x: bimaNode.position.x  - bimaNode.body.size.width / 4,
                y: bimaNode.position.y/1.65)
        )
        self.physicsWorld.add(leftStick)
        
        let rightStick: SKPhysicsJointPin = SKPhysicsJointPin.joint(
            withBodyA: bimaNode.rightStick.physicsBody!,
            bodyB: rightHandPhysics,
            anchor: .init(
                x: bimaNode.position.x + bimaNode.body.size.width / 2 - 4,
                y: bimaNode.position.y/1.65)
        )
        self.physicsWorld.add(rightStick)
        
        
        self.physicsWorld.add(rightArmJoint)
        self.physicsWorld.add(leftArmJoint)
        self.physicsWorld.add(rightHandJoint)
        self.physicsWorld.add(leftHandJoint)
        
        shadowBima.leftStick.isHidden = true
        shadowBima.rightStick.isHidden = true
        shadowBima.stickBody.isHidden = true
        shadowBima.leftStick.physicsBody?.categoryBitMask = 0x1 << 6
        shadowBima.rightStick.physicsBody?.categoryBitMask = 0x1 << 7
        shadowBima.stickBody.physicsBody?.categoryBitMask = 0x1 << 8
        shadowBima.leftStick.position = .init(x: -39, y: 79)
        shadowBima.rightStick.position = .init(x: -19, y: 26)
        
        //
        for child in Mirror(reflecting: shadowBima).children {
            if let node = child.value as? SKSpriteNode {
                node.color = .black
                node.colorBlendFactor = 1.0
            }
        }
    }
    
}



class BimaNode: SKSpriteNode{
    
    var body: SKSpriteNode!
    var rightArm: SKSpriteNode!
    var rightHand: SKSpriteNode!
    var leftArm: SKSpriteNode!
    var leftHand: SKSpriteNode!
    var stickBody: SKShapeNode!
    var leftStick: SKShapeNode!
    var rightStick: SKShapeNode!
    var rightRange: SKShapeNode!
    var leftRange: SKShapeNode!
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        
        createBody()
        configureBody()
    }
    
    private func createBody(){
        body = SKSpriteNode(imageNamed: "BimaBody")
        body.anchorPoint = .init(x: 0.5, y: 0.5)
        body.position = .init(x: 0, y: 0)
        body.size = .init(width: body.size.width/12, height: body.size.height/12)
        self.addChild(body)
        
        stickBody = SKShapeNode()
        let pathToDraw = CGMutablePath()
        pathToDraw.move(to: CGPoint(x: body.position.x, y: body.position.y))
        pathToDraw.addLine(to: CGPoint(x: body.position.x, y: -body.size.width*2))
        stickBody.path = pathToDraw
        stickBody.zPosition = -1
        stickBody.lineWidth = 5
        stickBody.strokeColor = UIColor(red: 205/255, green: 131/255, blue: 60/255, alpha: 1.0)
        stickBody.physicsBody = SKPhysicsBody(edgeChainFrom: pathToDraw)
        stickBody.name = "BimaStickBody"
        stickBody.physicsBody?.categoryBitMask = 0x1 << 5
        stickBody.physicsBody?.collisionBitMask = 0
        self.addChild(stickBody)
        
        
    }
    
    
    private func configureBody(){
        rightArm = SKSpriteNode(imageNamed: "BimaArm")
        rightArm.size = CGSize(width: rightArm.size.width/12, height: rightArm.size.height/12)
        rightArm.anchorPoint = .init(x: 0.48, y: 0.9)
        rightArm.position = .init(x: self.body.size.width / 2.2, y:  body.size.height / 6.3)
        self.addChild(rightArm)
        
        rightHand = SKSpriteNode(imageNamed: "BimaHand")
        rightHand.size = CGSize(width: rightHand.size.width/35, height: rightHand.size.height/35)
        rightHand.anchorPoint = .init(x: 0.8, y:0.95)
        rightHand.position = .init(x: self.body.size.width / 2.2, y: -self.rightHand.size.height/10)
        rightHand.name = "BimaRightHand"
        self.addChild(rightHand)
        
        leftArm = SKSpriteNode(imageNamed: "BimaArm")
        leftArm.size = CGSize(width: leftArm.size.width/12, height: leftArm.size.height/12)
        leftArm.anchorPoint = .init(x: 0.48, y: 0.9)
        leftArm.position = .init(x: -self.body.size.width / 4, y: body.size.height / 6.3)
        self.addChild(leftArm)
        
        leftHand = SKSpriteNode(imageNamed: "BimaHand")
        leftHand.size = CGSize(width: leftHand.size.width/35, height: leftHand.size.height/35)
        leftHand.anchorPoint = .init(x: 0.8, y:0.95)
        leftHand.position = .init(x: -self.body.size.width / 4, y: -self.rightHand.size.height/10)
        leftHand.name = "BimaLeftHand"
        self.addChild(leftHand)
        
        leftStick = SKShapeNode()
        let path = CGMutablePath()
        path.move(to: CGPoint(x: leftHand.position.x, y: -leftHand.position.y-40))
        path.addLine(to: CGPoint(x: leftHand.position.x, y: -300))
        leftStick.name = "BimaLeftStick"
        leftStick.path = path
        leftStick.lineWidth = 4
        leftStick.zPosition = -1
        leftStick.strokeColor = UIColor(red: 205/255, green: 131/255, blue: 60/255, alpha: 1.0)
        leftStick.physicsBody = SKPhysicsBody(edgeChainFrom: path)
        leftStick.physicsBody?.categoryBitMask = 0x1 << 9
        leftStick.physicsBody?.collisionBitMask = 0
        self.addChild(leftStick)
        
        rightStick = SKShapeNode()
        let path2 = CGMutablePath()
        path2.move(to: CGPoint(x: rightHand.position.x, y: -rightHand.position.y-40))
        path2.addLine(to: CGPoint(x: rightHand.position.x, y: -300))
        rightStick.name = "BimaRightStick"
        rightStick.path = path2
        rightStick.lineWidth = 4
        rightStick.zPosition = -1
        rightStick.strokeColor = UIColor(red: 205/255, green: 131/255, blue: 60/255, alpha: 1.0)
        rightStick.physicsBody = SKPhysicsBody(edgeChainFrom: path2)
        rightStick.physicsBody?.categoryBitMask = 0x1 << 4
        rightStick.physicsBody?.collisionBitMask = 0
        self.addChild(rightStick)
        
        let maxRange: CGFloat = self.leftArm.size.height + self.leftHand.size.height - 25
        let circlePath = UIBezierPath(arcCenter: CGPoint.zero, radius: maxRange, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
        rightRange = SKShapeNode(path: circlePath.cgPath)
        rightRange.position = rightArm.position
        rightRange.isHidden = true
        self.addChild(rightRange)
        
        let circlePath2 = UIBezierPath(arcCenter: CGPoint.zero, radius: maxRange, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
        leftRange = SKShapeNode(path: circlePath2.cgPath)
        leftRange.position = leftArm.position
        leftRange.isHidden = true
        self.addChild(leftRange)
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
}
