//
//  Pandawa.swift
//  WayangCoba
//
//  Created by Kezia Gloria on 17/04/23.
//

import SwiftUI
import SpriteKit

class PandawaScene: SKScene{
    let bimaNode: BimaNode = BimaNode()
    let yudhistiraNode: YudhistiraNode = YudhistiraNode()
    let arjunaNode: ArjunaNode = ArjunaNode()
    let sadewaNode: TwinsNode = TwinsNode()
    let nakulaNode: TwinsNode = TwinsNode()
    @ObservedObject var dataWayang: DataWayang
    


    init(size: CGSize, dataWayang: DataWayang) {
        self.dataWayang = dataWayang
        super.init(size: size)
        
        self.addChild(yudhistiraNode)
        self.addChild(bimaNode)
        self.addChild(arjunaNode)
        self.addChild(sadewaNode)
        self.addChild(nakulaNode)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMove(to view: SKView) {
        self.backgroundColor = .clear
        
        bimaNode.position = .init(x: 125, y: 105)
        yudhistiraNode.position = .init(x: 50, y: 100)
        arjunaNode.position = .init(x: 200, y: 100)
        sadewaNode.position = .init(x: 275, y: 100)
        nakulaNode.position = .init(x: 340, y: 100)
        
        bimaNode.leftStick.isHidden = true
        bimaNode.rightStick.isHidden = true
        bimaNode.stickBody.isHidden = true
        
        yudhistiraNode.leftStick.isHidden = true
        yudhistiraNode.rightStick.isHidden = true
        yudhistiraNode.stickBody.isHidden = true
        
        arjunaNode.leftStick.isHidden = true
        arjunaNode.rightStick.isHidden = true
        arjunaNode.stickBody.isHidden = true
        
        sadewaNode.leftStick.isHidden = true
        sadewaNode.rightStick.isHidden = true
        sadewaNode.stickBody.isHidden = true
        
        nakulaNode.leftStick.isHidden = true
        nakulaNode.rightStick.isHidden = true
        nakulaNode.stickBody.isHidden = true
    }
}
