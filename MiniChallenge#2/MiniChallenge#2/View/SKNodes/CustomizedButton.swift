import SpriteKit

public class CustomizedButton: SKNode {
    var buttonView: SKSpriteNode
    private var mask: SKSpriteNode
    private var cropNode:  SKCropNode
    private var action: () -> Void
    var enable = true
    
    init(imageName: String, buttonAction: @escaping () -> Void) {
        self.buttonView = SKSpriteNode(imageNamed: imageName)
        
        self.mask = SKSpriteNode(color: SKColor.black, size: buttonView.size)
        self.mask.alpha = 0
        
        self.cropNode = SKCropNode()
        self.cropNode.maskNode = buttonView
        self.cropNode.zPosition = 3
        self.cropNode.addChild(mask)
        
        self.action = buttonAction
        
        super.init()
        
        isUserInteractionEnabled = true
        
        self.setupNodes()
        self.addNodes()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupNodes() {
        self.buttonView.zPosition = 0
        buttonView.setScale(1.2)
    }
    
    func addNodes() {
        self.addChild(buttonView)
        self.addChild(cropNode)
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if enable {
            for touch in touches {
                let location: CGPoint = touch.location(in: self)
                
                if buttonView.contains(location) {
                    mask.alpha = 0.5
                } else {
                    mask.alpha = 0.0
                }
            }
        }
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.enable {
            for touch in touches {
                let location: CGPoint = touch.location(in: self)

                if self.buttonView.contains(location) {
                    self.disableButton()
                    self.action()
                    run(SKAction.sequence([SKAction.wait(forDuration: 0.2), SKAction.run({
                        self.enableButton()
                    })]))
                }
            }
        }
    }
    
    
    
    //Nao permitir duplo clique e deixar botao transparente ao clicar
    func disableButton() {
        self.enable = false
        self.mask.alpha = 0.0
        self.buttonView.alpha = 0.5
        
    }
    
    func enableButton() {
        self.enable = true
        self.mask.alpha = 0.0
        self.buttonView.alpha = 1.0
    }
    
    
}
