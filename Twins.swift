import SwiftUI
import SpriteKit

class TwinsScene: SKScene{
    
    let wayangNode: TwinsNode = TwinsNode()
    let wayangNode2: TwinsNode = TwinsNode()
    @ObservedObject var dataWayang: DataWayang
    
    
    init(size: CGSize, dataWayang: DataWayang) {
        self.dataWayang = dataWayang
        super.init(size: size)
        self.addChild(wayangNode)
        
        if (dataWayang.showNakulaDesc == false && dataWayang.showSadewaDesc  == false) {
            self.addChild(wayangNode2)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        self.backgroundColor = .clear
        
        
        if (dataWayang.showNakulaDesc == false && dataWayang.showSadewaDesc  == false){
            wayangNode2.position = .init(x: 150, y: 125)
            wayangNode2.zPosition = -2
            configPhysics(wayangNode: wayangNode2)
            
            configShadow()
        }
        
        wayangNode.position = .init(x: 125, y: 125)
        configPhysics(wayangNode: wayangNode)
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        let previousLocation = touch.previousLocation(in: self)
        let touchedNodes = nodes(at: touchLocation)
        
        for node in touchedNodes {
            
            let radius = wayangNode.rightRange.frame.width/4
            if dataWayang.showNakulaDesc == false || dataWayang.showSadewaDesc == false{
                if node.name == "TwinsRightStick"{
                    let distance = hypot(wayangNode.rightHand.position.x - wayangNode.rightRange.position.x, wayangNode.rightHand.position.y - wayangNode.rightRange.position.y)
                    if distance <= radius {
                        node.position = CGPoint(x: node.position.x + touchLocation.x - previousLocation.x, y: node.position.y + touchLocation.y - previousLocation.y)
                    }else{
                        node.position = CGPoint(x: node.position.x + (wayangNode.rightRange.position.x - wayangNode.rightHand.position.x < 0 ? -1 : 1), y: node.position.y + (wayangNode.rightRange.position.y - wayangNode.rightHand.position.y < 0 ? -1 : 1))
                    }
                }else if node.name == "TwinsLeftStick" {
                    let distance = hypot(wayangNode.leftHand.position.x - wayangNode.leftRange.position.x, wayangNode.leftHand.position.y - wayangNode.leftRange.position.y)
                    if distance <= radius {
                        node.position = CGPoint(x: node.position.x + touchLocation.x - previousLocation.x, y: node.position.y + touchLocation.y - previousLocation.y)
                    }else{
                        print("\(wayangNode.leftRange.position.y - wayangNode.leftHand.position.y)")
                        node.position = CGPoint(x: node.position.x + (wayangNode.leftRange.position.x - wayangNode.leftHand.position.x < 0 ? -1 : 1), y: node.position.y + (wayangNode.leftRange.position.y - wayangNode.leftHand.position.y < 0 ? -1 : 1))
                    }
                }
                
                
                if  node.name == "TwinsStickBody" && (120...165).contains(touchLocation.x) {
                    wayangNode.position.x =  touchLocation.x
                    
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        var difficulty = 0.0
        
        if dataWayang.isNakula{
            difficulty = 0.35
        }else{
            difficulty = 0.2
        }
        
        let duration = 1.0
        var ctr = 0
        if ((wayangNode2.position.x - difficulty ... wayangNode2.position.x + difficulty).contains(wayangNode.position.x)){
            
            let moveAction = SKAction.move(to: wayangNode2.position, duration: duration)
            wayangNode.run(moveAction)
            wayangNode.stickBody.isHidden = true
            ctr += 1
        }
        
        if((wayangNode2.leftHand.position.x - difficulty ... wayangNode2.leftHand.position.x + difficulty).contains(wayangNode.leftHand.position.x) && (wayangNode2.leftArm.position.x - difficulty ... wayangNode2.leftArm.position.x + difficulty).contains(wayangNode.leftArm.position.x) && (wayangNode2.leftHand.zRotation - difficulty ... wayangNode2.leftHand.zRotation + difficulty).contains(wayangNode.leftHand.zRotation) && (wayangNode2.leftArm.zRotation - difficulty ... wayangNode2.leftArm.zRotation + difficulty).contains(wayangNode.leftArm.zRotation)){
            let moveAction = SKAction.move(to: wayangNode2.leftStick.position, duration: duration)
            wayangNode.leftStick.run(moveAction)
            wayangNode.leftStick.isHidden = true
            ctr += 1
        }
        
        if((wayangNode2.rightHand.position.x - difficulty ... wayangNode2.rightHand.position.x + difficulty).contains(wayangNode.rightHand.position.x) && (wayangNode2.rightArm.position.x - difficulty ... wayangNode2.rightArm.position.x + difficulty).contains(wayangNode.rightArm.position.x) && (wayangNode2.rightHand.zRotation - difficulty ... wayangNode2.rightHand.zRotation + difficulty).contains(wayangNode.rightHand.zRotation) && (wayangNode2.rightArm.zRotation - difficulty ... wayangNode2.rightArm.zRotation + difficulty).contains(wayangNode.rightArm.zRotation)){
            let moveAction = SKAction.move(to: wayangNode2.rightStick.position, duration: duration)
            wayangNode.rightStick.run(moveAction)
            wayangNode.rightStick.isHidden = true
            ctr += 1
        }

        if ctr == 3 {
            let delay = SKAction.wait(forDuration: 2.5)
            let hideAction = SKAction.hide()
            let sequence = SKAction.sequence([delay, hideAction])
            wayangNode2.run(sequence)
            if dataWayang.isNakula {
                dataWayang.showNakulaDesc = true
            }else{
                dataWayang.showSadewaDesc = true
            }
        }
    }

    
    private func configPhysics(wayangNode: TwinsNode){
        
        let bodyPhysics = SKPhysicsBody(rectangleOf: wayangNode.body.size)
        bodyPhysics.affectedByGravity = false
        bodyPhysics.collisionBitMask = 0
        bodyPhysics.contactTestBitMask = 0x1 << 1
        bodyPhysics.categoryBitMask = 0x1 << 6
        wayangNode.body.physicsBody = bodyPhysics
        
        let rightArmPhysics = SKPhysicsBody(rectangleOf: wayangNode.rightArm?.size ?? .zero)
        rightArmPhysics.allowsRotation = true
        rightArmPhysics.affectedByGravity = false
        rightArmPhysics.collisionBitMask = 0
        rightArmPhysics.contactTestBitMask = 0x1 << 2
        rightArmPhysics.categoryBitMask = 0x1 << 7
        rightArmPhysics.density = 2
        wayangNode.rightArm.physicsBody = rightArmPhysics
        
        let rightHandPhysics = SKPhysicsBody(rectangleOf: wayangNode.rightHand?.size ?? .zero)
        rightHandPhysics.allowsRotation = true
        rightHandPhysics.affectedByGravity = false
        rightHandPhysics.collisionBitMask = 0
        rightHandPhysics.contactTestBitMask = 0x1 << 3
        rightHandPhysics.categoryBitMask = 0x1 << 8
        rightHandPhysics.density = 2
        wayangNode.rightHand.physicsBody = rightHandPhysics
        
        
        let leftArmPhysics = SKPhysicsBody(rectangleOf: wayangNode.leftArm?.size ?? .zero)
        leftArmPhysics.allowsRotation = true
        leftArmPhysics.affectedByGravity = false
        leftArmPhysics.collisionBitMask = 0
        leftArmPhysics.contactTestBitMask =  0x1 << 2
        leftArmPhysics.categoryBitMask = 0x1 << 7
        wayangNode.leftArm.physicsBody = leftArmPhysics
        
        let leftHandPhysics = SKPhysicsBody(rectangleOf: wayangNode.leftArm?.size ?? .zero)
        leftHandPhysics.allowsRotation = true
        leftHandPhysics.affectedByGravity = false
        leftHandPhysics.collisionBitMask = 0
        leftHandPhysics.contactTestBitMask = 0x1 << 3
        leftHandPhysics.categoryBitMask = 0x1 << 8
        wayangNode.leftHand.physicsBody = leftHandPhysics
        
        
        let rightArmJoint: SKPhysicsJointPin = SKPhysicsJointPin.joint(
            withBodyA: rightArmPhysics,
            bodyB: bodyPhysics,
            anchor: .init(
                x: wayangNode.position.x + wayangNode.body.size.width / 2.37,
                y: wayangNode.position.y + wayangNode.body.size.height / 4.3)
        )
        
        let rightHandJoint: SKPhysicsJointPin = SKPhysicsJointPin.joint(
            withBodyA: rightArmPhysics,
            bodyB: rightHandPhysics,
            anchor: .init(
                x: wayangNode.position.x + wayangNode.body.size.width / 2.37,
                y: wayangNode.position.y + 3
            )
        )
        
        let leftArmJoint: SKPhysicsJointPin = SKPhysicsJointPin.joint(
            withBodyA: leftArmPhysics,
            bodyB: bodyPhysics,
            anchor: .init(
                x: wayangNode.position.x  - wayangNode.body.size.width / 4.1,
                y: wayangNode.position.y + wayangNode.body.size.height / 4.3)
        )
        
        let leftHandJoint: SKPhysicsJointPin = SKPhysicsJointPin.joint(
            withBodyA: leftArmPhysics,
            bodyB: leftHandPhysics,
            anchor: .init(
                x: wayangNode.position.x - wayangNode.body.size.width / 4.1,
                y: wayangNode.position.y + 3)
        )
        
        let stickBody: SKPhysicsJointFixed = SKPhysicsJointFixed.joint(
            withBodyA: bodyPhysics,
            bodyB: wayangNode.stickBody.physicsBody!,
            anchor: .init(
                x: wayangNode.position.x,
                y: wayangNode.position.y)
        )
        
        
        let leftStick: SKPhysicsJointPin = SKPhysicsJointPin.joint(
            withBodyA: wayangNode.leftStick.physicsBody!,
            bodyB: leftHandPhysics,
            anchor: .init(
                x: wayangNode.position.x - wayangNode.body.size.width / 4,
                y: wayangNode.position.y/1.5)
        )
        self.physicsWorld.add(leftStick)
        
        let rightStick: SKPhysicsJointPin = SKPhysicsJointPin.joint(
            withBodyA: wayangNode.rightStick.physicsBody!,
            bodyB: rightHandPhysics,
            anchor: .init(
                x: wayangNode.position.x + wayangNode.body.size.width / 2.37,
                y: wayangNode.position.y / 1.5)
        )
        self.physicsWorld.add(stickBody)
        self.physicsWorld.add(rightStick)
        
        
        self.physicsWorld.add(rightArmJoint)
        self.physicsWorld.add(leftArmJoint)
        self.physicsWorld.add(rightHandJoint)
        self.physicsWorld.add(leftHandJoint)
    }
    
    
    private func configShadow(){
        wayangNode2.leftStick.isHidden = true
        wayangNode2.rightStick.isHidden = true
        wayangNode2.stickBody.isHidden = true
        if dataWayang.isNakula{
            wayangNode2.leftStick.position =  .init(x: 16, y: 37)
            wayangNode2.rightStick.position =  .init(x: -5, y: 99)
        }else{
            wayangNode2.leftStick.position =  .init(x: 10, y: 41)
            wayangNode2.rightStick.position =  .init(x: -25, y: 61)
        }
        
        
        for child in Mirror(reflecting: wayangNode2).children {
            if let node = child.value as? SKSpriteNode {
                node.color = .black
                node.colorBlendFactor = 1.0
            }
        }
    }
    
}



class TwinsNode: SKSpriteNode{
    
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
        body = SKSpriteNode(imageNamed: "TwinsBody")
        body.anchorPoint = .init(x: 0.5, y: 0.5)
        body.position = .init(x: 0, y: 3)
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
        stickBody.name = "TwinsStickBody"
        stickBody.physicsBody?.categoryBitMask = 100
        stickBody.physicsBody?.collisionBitMask = 0
        self.addChild(stickBody)
        
        
    }
    
    
    private func configureBody(){
        rightArm = SKSpriteNode(imageNamed: "TwinsArm")
        rightArm.size = CGSize(width: rightArm.size.width/55, height: rightArm.size.height/55)
        rightArm.anchorPoint = .init(x: 0.48, y: 0.93)
        rightArm.position = .init(x: self.body.size.width / 2.4, y:  body.size.height / 4.3)
        self.addChild(rightArm)
        
        rightHand = SKSpriteNode(imageNamed: "TwinsHand")
        rightHand.size = CGSize(width: rightHand.size.width/35, height: rightHand.size.height/35)
        rightHand.anchorPoint = .init(x: 0.72, y:0.95)
        rightHand.position = .init(x: self.rightHand.size.width * 1.9, y: self.rightHand.size.height/20)
        rightHand.name = "TwinsRightHand"
        self.addChild(rightHand)
        
        leftArm = SKSpriteNode(imageNamed: "TwinsArm")
        leftArm.size = CGSize(width: leftArm.size.width/55, height: leftArm.size.height/55)
        leftArm.anchorPoint = .init(x: 0.48, y: 0.93)
        leftArm.position = .init(x: -self.body.size.width / 4.2, y:  body.size.height / 4.3)
        self.addChild(leftArm)
        
        leftHand = SKSpriteNode(imageNamed: "TwinsHand")
        leftHand.size = CGSize(width: leftHand.size.width/35, height: leftHand.size.height/35)
        leftHand.anchorPoint = .init(x: 0.72, y:0.95)
        leftHand.position = .init(x: -self.rightHand.size.width-1, y: self.leftHand.size.height/20)
        leftHand.name = "TwinsLeftHand"
        self.addChild(leftHand)
        
        leftStick = SKShapeNode()
        let path = CGMutablePath()
        path.move(to: CGPoint(x: leftHand.position.x, y: -leftHand.position.y*15))
        path.addLine(to: CGPoint(x: leftHand.position.x, y: -400))
        leftStick.name = "TwinsLeftStick"
        leftStick.path = path
        leftStick.lineWidth = 4
        leftStick.zPosition = -1
        leftStick.strokeColor = UIColor(red: 205/255, green: 131/255, blue: 60/255, alpha: 1.0)
        leftStick.physicsBody = SKPhysicsBody(edgeChainFrom: path)
        leftStick.physicsBody?.categoryBitMask = 2
        leftStick.physicsBody?.collisionBitMask = 0
        self.addChild(leftStick)
        
        rightStick = SKShapeNode()
        let path2 = CGMutablePath()
        path2.move(to: CGPoint(x: rightHand.position.x, y: -rightHand.position.y*15))
        path2.addLine(to: CGPoint(x: rightHand.position.x, y: -400))
        rightStick.name = "TwinsRightStick"
        rightStick.path = path2
        rightStick.lineWidth = 4
        rightStick.zPosition = -1
        rightStick.strokeColor = UIColor(red: 205/255, green: 131/255, blue: 60/255, alpha: 1.0)
        rightStick.physicsBody = SKPhysicsBody(edgeChainFrom: path2)
        rightStick.physicsBody?.categoryBitMask = 3
        rightStick.physicsBody?.collisionBitMask = 0
        self.addChild(rightStick)
        
        let maxRange: CGFloat = self.leftArm.size.height + self.leftHand.size.height - 20
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
