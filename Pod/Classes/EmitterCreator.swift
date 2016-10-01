//
//  EmitterCreator.swift
//  ParticlesLoadingView
//
//  Created by Patrick Balestra on 5/16/16.
//
//

import UIKit
import SpriteKit

public class EmitterCreator {
    
    public enum EmitterError: Error {
        case emitterNodeUnavailable
    }
    
    /// Creates a SKEmitterNode from one of the predefined particle emitter files.
    ///
    /// - throws: An error if the file could not be found.
    ///
    /// - returns: The emitter node object.
    func createEmitterNode(with effect: ParticleEffect) throws -> SKEmitterNode {
        let bundle = Bundle(for: type(of: self))
        let bundleName = bundle.infoDictionary!["CFBundleName"] as! String
        let path = Bundle(for: type(of: self)).path(forResource: effect.rawValue, ofType: "sks", inDirectory: "\(bundleName).bundle")
        if let path = path, let emitter = NSKeyedUnarchiver.unarchiveObject(withFile: path) as? SKEmitterNode, let texture = UIImage(named: "\(bundleName).bundle/spark", in: bundle, compatibleWith: nil) {
            emitter.particleTexture = SKTexture(image: texture)
            return emitter
        } else {
            throw EmitterError.emitterNodeUnavailable
        }
    }
}

