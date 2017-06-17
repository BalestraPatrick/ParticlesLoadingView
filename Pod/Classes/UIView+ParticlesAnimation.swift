//
//  UIView+ParticlesAnimation.swift
//  ParticlesLoadingView
//
//  Created by Patrick Balestra on 2/8/16.
//
//

import UIKit
import SpriteKit

public extension UIView {
    
    /// Add a particles animation with a SKEmitterNode.
    ///
    /// - parameter emitter: Emitter node object.
    public func addParticlesAnimation(with emitter: SKEmitterNode? = nil, effect: ParticleEffect? = nil) {
        var spriteKitView = SKView()
        spriteKitView = SKView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        spriteKitView.backgroundColor = UIColor.clear
        
        var scene: ParticlesScene
        if let emitter = emitter {
            scene = ParticlesScene(size: frame.size, emitterNode: emitter)
        } else if let effect = effect {
            do {
                let emitter = try EmitterCreator().createEmitterNode(with: effect)
                scene = ParticlesScene(size: frame.size, emitterNode: emitter)
            } catch {
                fatalError("The default ParticleEffect could not be loaded.")
            }
        } else {
            fatalError("Please provide at least a SKEmitterNode or a select a default ParticleEffect.")
        }
        
        if let backgroundColor = backgroundColor {
            scene.backgroundColor = backgroundColor
        }
        spriteKitView.presentScene(scene)
        addSubview(spriteKitView)
        scene.setAnimationPath()
    }
    
    /// Start animating the emitter node.
    @objc public func startAnimating() {
        for case let spriteKitView as SKView in subviews {
            if let scene = spriteKitView.scene, let particlesScene = scene as? ParticlesScene {
                particlesScene.startAnimating()
            }
        }
    }
    
    /// Stop animating the emitter node.
    @objc public func stopAnimating() {
        for case let spriteKitView as SKView in subviews {
            if let scene = spriteKitView.scene, let particlesScene = scene as? ParticlesScene {
                particlesScene.stopAnimating()
            }
        }
    }
    
    /// Returns true if the animation is ongoing, otherwise false.
    @objc public func isEmitting() -> Bool {
        for case let spriteKitView as SKView in subviews {
            if let scene = spriteKitView.scene, let particlesScene = scene as? ParticlesScene {
                return particlesScene.isEmitting()
            }
        }
        return false
    }
}
