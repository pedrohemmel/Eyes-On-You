//
//  GameViewController.swift
//  MiniChallenge#2
//
//  Created by Pedro Henrique Dias Hemmel de Oliveira Souza on 16/11/22.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //test
        AppUtility.lockOrientation(.landscape)
        let myView: SKView = SKView(frame: self.view.bounds)
        self.view = myView
        myView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        myView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        myView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        myView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        // Set the scale mode to scale to fit the window
        let gameScene = StoryAnimationScene(size: myView.bounds.size)
        // Present the scene
        gameScene.scaleMode = .resizeFill
        myView.presentScene(gameScene)
        myView.ignoresSiblingOrder = true
            
//        myView.showsPhysics = true
//        myView.showsFPS = true
//        myView.showsNodeCount = true
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}

struct AppUtility {
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask){
        if let delegate = UIApplication.shared.delegate as? AppDelegate{
            delegate.orientationLock = orientation
        }
    }
    
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask, andRotateTo rotateOrientation:UIInterfaceOrientation) {
        self.lockOrientation(orientation)
        UIDevice.current.setValue(rotateOrientation.rawValue, forKey: "orientation")
    }
}
