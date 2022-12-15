//
//  AnimatedObject.swift
//  MiniChallenge#2
//
//  Created by Pedro Henrique Dias Hemmel de Oliveira Souza on 17/11/22.
//

import SpriteKit

class AnimatedObject: SKSpriteNode {
    
    var nameOfAtlas: String?
    
    var animationFinished = false
    
    //Initalizer of the class
    init(_ nameOfAtlas: String, countRepeat: Int? = nil, lastImageDesired: Int? = nil){
        self.nameOfAtlas = nameOfAtlas
        
        //Searching for the atlas repository name
        
        var texture = SKTexture()
        
        if lastImageDesired != nil {
            texture = SKTexture(imageNamed: "\(nameOfAtlas)\(lastImageDesired!)")
        } else {
            texture = SKTexture(imageNamed: "\(nameOfAtlas)1")
        }
        
        super.init(texture: texture, color: .red, size: texture.size())
        
        
        self.setup(countRepeat: countRepeat)
    }

    //If the class is not initialized
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func gettingStatusAnimationFinished() -> Bool{
        return animationFinished
    }

    func setup(countRepeat: Int? = nil){
        
        var image: [SKTexture] = []
        let atlas: SKTextureAtlas = SKTextureAtlas(named: nameOfAtlas!)
        
        
        
        //Loop to make the "gif"
        for i in 1...atlas.textureNames.count {
            image.append(SKTexture(imageNamed: "\(self.nameOfAtlas!)\(i)"))
        }
        
        
        
        //Properties that start the animation
        let animation: SKAction = SKAction.animate(with: image, timePerFrame: 0.2, resize: true, restore: true)
        
        if countRepeat != nil {
            self.run(SKAction.repeat(animation, count: countRepeat!))
            
            self.animationFinished = true
        } else {
            self.run(SKAction.repeatForever(animation))
        }
        
    }
}
