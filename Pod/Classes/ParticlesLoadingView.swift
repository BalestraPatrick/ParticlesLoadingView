//
//  ParticlesLoadingView.swift
//  ParticlesLoadingView
//
//  Created by Patrick Balestra on 1/30/16.
//
//

import UIKit
import SpriteKit

public class ParticlesLoadingView: UIView {
    
    /// Duration in seconds of the animation to complete a tour on the border of the view.
    public var duration = 2.0
    
    /// The size of each particle image. This value is used to calculate the inner padding of the view path so that the emitted particles are visible.
    public var particlesSize: CGFloat = 5.0
    
    /// The emitter of particles that is animated along the border of the view.
    public var emitterNode: SKEmitterNode? = nil {
        didSet {
            if let emitter = emitterNode {
                scene.setEmitterNode(emitter)
            }
        }
    }
    
    /// Default value is false so the animation is counter-clockwise. Set this property to true to make the animation go clockwise.
    public var clockwiseRotation: Bool = false
    
    /// SKScene subclass that is responsible for the emission of particles.
    private var scene: ParticlesScene!
    
    /// Emitter creator used to create one of the default particle effects.
    private let emitterCreator = EmitterCreator()
    
    /// The particle effect used to emit particles.
    public var particleEffect = ParticleEffect.laser {
        didSet {
            if let _ = scene {
                do {
                    let emitter = try emitterCreator.createEmitterNode(with: particleEffect)
                    scene.setEmitterNode(emitter)
                } catch {
                    fatalError("Could not find the particles file")
                }
            } else {
                setUp()
            }
        }
    }
    
    /// The underlying SpriteKit view that renders the particles.
    private var spriteKitView = SKView()
    
    // MARK: - Initialization
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        spriteKitView = SKView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        spriteKitView.backgroundColor = UIColor.clear
        setUp()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        spriteKitView = SKView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        spriteKitView.backgroundColor = UIColor.clear
        setUp()
    }
    
    func setUp() {
        do {
            let emitter = try emitterCreator.createEmitterNode(with: particleEffect)
            scene = ParticlesScene(size: frame.size, emitterNode: emitter)
            spriteKitView.presentScene(scene)
            addSubview(spriteKitView)
        } catch _ {
            fatalError("Could not find the particles file")
        }
    }
    
    /// Start the particles emission and the animation around the border of the view.
    @objc public override func startAnimating() {
        scene.startAnimating()
    }
    
    /// Stop the particles emission.
    @objc public override func stopAnimating() {
        scene.stopAnimating()
    }
    
    /// Returns true if the view is emmitting particles, otherwise false.
    @objc public override func isEmitting() -> Bool {
        return scene.isEmitting()
    }
    
    // UIView automatically invoke this function when a view adds me as a subview. It is used to get the border path of the view.
    public override func willMove(toSuperview newSuperview: UIView?) {
        scene.setAnimationPath()
    }
    
}
