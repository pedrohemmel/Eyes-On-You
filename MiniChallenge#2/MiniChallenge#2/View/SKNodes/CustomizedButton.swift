import SpriteKit

public class CustomizedButton: SKNode {
    var buttonView: SKSpriteNode
    var lblView: SKLabelNode
    private var mask: SKSpriteNode
    private var cropNode:  SKCropNode
    private var action: () -> Void
    var enable = true
    
    init(imageName: String, lblText: String?, buttonAction: @escaping () -> Void) {
        self.buttonView = SKSpriteNode(imageNamed: imageName)
        let lblView = SKLabelNode()
        if lblText != nil {
            lblView.text = lblText!.localizedLanguage()
        }
        lblView.fontName = "AvenirNext-Bold"
        lblView.fontColor = UIColor.black
        self.lblView = lblView
        
        self.mask = SKSpriteNode(color: SKColor.black, size: buttonView.size)
        self.mask.alpha = 0
        
        self.cropNode = SKCropNode()
        self.cropNode.maskNode = buttonView
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
        self.lblView.position = CGPoint(x: self.frame.width / 2, y: (self.frame.height / 2) - (self.lblView.frame.height / 2))
        self.lblView.zPosition = 2
        
        self.buttonView.zPosition = 1
        buttonView.setScale(2.2)
    }
    
    func addNodes() {
        self.addChild(self.lblView)
        self.addChild(self.buttonView)
        self.addChild(self.cropNode)
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
