//
//  ParticlesScene.swift
//  ParticlesLoadingView
//
//  Created by Patrick Balestra on 1/30/16.
//
//

import UIKit
import SpriteKit

public class ParticlesScene: SKScene {
    
    /// Main emitter node: modify its properties as you wish.
    private var emitterNode: SKEmitterNode = SKEmitterNode() {
        didSet {
            emitterNode.position = CGPointZero
        }
    }
    
    /// Loop action to move the emitter node around the view's border path
    private var loopAction: SKAction!
    
    // MARK: - Initialization
    
    public init(size: CGSize, emitterNode: SKEmitterNode) {
        self.emitterNode = emitterNode
        self.emitterNode.position = CGPointMake(10, 0)
        super.init(size: size)
        backgroundColor = UIColor.clearColor()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /// Set a new emitter node as the source of the particles.
    ///
    /// - parameter emitter: The object that will emit the particles.
    public func setEmitterNode(emitter: SKEmitterNode) {
        self.emitterNode = emitter
    }
    
    /// Start animating the emitter node with the default values.
    func startAnimating() {
        emitterNode.particleBirthRate = 5000.0
        emitterNode.targetNode = scene
        emitterNode.runAction(loopAction, withKey: "loop")
        if emitterNode.parent == nil {
            addChild(emitterNode)
        }
    }
    
    /// Stop animating the emitter node.
    func stopAnimating() {
        emitterNode.particleBirthRate = 0
    }
    
    /// Returns true if the animation is ongoing, otherwise false.
    func isEmitting() -> Bool {
        return emitterNode.particleBirthRate != 0
    }
    
    /// Figure out the border path of the view and set it as the path of the animation. 
    func setAnimationPath() {
        var radii = CGSizeZero
        if let radius = view?.superview?.layer.cornerRadius {
            radii = CGSize(width: radius, height: radius)
        }
        let duration = (view?.superview as? ParticlesLoadingView)?.duration ?? 1.5
        let particlesSize = (view?.superview as? ParticlesLoadingView)?.particlesSize ?? 5.0
        if let scene = scene {
            let border = UIBezierPath(roundedRect: scene.frame, byRoundingCorners: .AllCorners, cornerRadii: radii)
            let horizontalInsetScaleFactor: CGFloat = 1 - (particlesSize / scene.frame.size.width)
            let verticalInsetScaleFactor: CGFloat = 1 - (particlesSize / scene.frame.size.height)
            let horizontalTranslationFactor = 2 / (1 - horizontalInsetScaleFactor)
            let verticalTranslationFactor = 2 / (1 - verticalInsetScaleFactor)
            border.applyTransform(CGAffineTransformMakeScale(horizontalInsetScaleFactor, verticalInsetScaleFactor))
            border.applyTransform(CGAffineTransformMakeTranslation(scene.frame.size.width / horizontalTranslationFactor, scene.frame.size.height / verticalTranslationFactor))
            let followLine = SKAction.followPath(border.CGPath, asOffset: false, orientToPath: true, duration: duration)
            loopAction = SKAction.repeatActionForever(followLine)
        }
    }
}

        