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
        
        AppUtility.lockOrientation(.landscape) //calling struct
        
        //creating my SKView
        let myView:SKView = SKView(frame: self.view.frame)
        self.view = myView
        
        // creating scene and presenting on SKView
        let GameScene: GameScene = GameScene(size: myView.frame.size)
        myView.contentMode = .scaleAspectFill
        myView.presentScene(GameScene)
        myView.ignoresSiblingOrder = false //sobreposicao de item
        myView.showsFPS = true
        myView.showsNodeCount = true
        myView.showsPhysics = true
     
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
