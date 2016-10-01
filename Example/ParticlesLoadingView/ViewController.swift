//
//  ViewController.swift
//  ParticlesLoadingView
//
//  Created by Patrick Balestra on 01/30/2016.
//  Copyright (c) 2016 Patrick Balestra. All rights reserved.
//

import UIKit
import SpriteKit
import ParticlesLoadingView

class ViewController: UIViewController {
    
    @IBOutlet weak var circleLoadingView: UIView!
    @IBOutlet weak var messageView: UIView!
    
    lazy var loadingView: ParticlesLoadingView = {
        let x = UIScreen.main.bounds.size.width / 2 - (75 / 2) - 200 // 🙈
        let y = UIScreen.main.bounds.size.height / 2 - (75 / 2) // 🙉
        let view = ParticlesLoadingView(frame: CGRect(x: x, y: y, width: 75, height: 75))
        view.particleEffect = .laser
        view.duration = 1.5
        view.particlesSize = 15.0
        view.clockwiseRotation = true
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 1.0
        view.layer.cornerRadius = 15.0
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add and start a view animation
        view.addSubview(loadingView)
        loadingView.startAnimating()
        
        // Customize view, choose the Fire effect and start the animation.
        messageView.layer.cornerRadius = 15.0
        messageView.layer.borderColor = UIColor.lightGray.cgColor
        messageView.layer.borderWidth = 1.0
        messageView.addParticlesAnimation(effect: ParticleEffect.fire)
        messageView.startAnimating()
        
        // Use a custom emitter particles file and customize the view.
        if let emitter = NSKeyedUnarchiver.unarchiveObject(withFile: Bundle.main.path(forResource: "Spark", ofType: "sks")!) as? SKEmitterNode {
            circleLoadingView.layer.borderWidth = 1.0
            circleLoadingView.layer.borderColor = UIColor.lightGray.cgColor
            circleLoadingView.layer.cornerRadius = circleLoadingView.frame.size.width / 2
            circleLoadingView.addParticlesAnimation(with: emitter)
            circleLoadingView.startAnimating()
        }
    }
    
    @IBAction func controlAnimation(_ sender: UIButton) {
        if circleLoadingView.isEmitting() {
            circleLoadingView.stopAnimating()
            loadingView.stopAnimating()
            messageView.stopAnimating()
            sender.setTitle("Start Animating", for: UIControlState())
        } else {
            circleLoadingView.startAnimating()
            loadingView.startAnimating()
            messageView.startAnimating()
            sender.setTitle("Stop Animating", for: UIControlState())
        }
    }
}

