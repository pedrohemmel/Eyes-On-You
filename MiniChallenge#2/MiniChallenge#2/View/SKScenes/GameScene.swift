//
//  GameScene.swift
//  MiniChallenge#2
//
//  Created by Pedro Henrique Dias Hemmel de Oliveira Souza on 16/11/22.
//

import SpriteKit
import GameplayKit


class GameScene: SKScene, SKPhysicsContactDelegate {
    
    private var menu: Menu? = nil
    private var pausedGameScreen: PausedGame? = nil
    private var gameOverScreen: GameOver? = nil
    
    private let character = Character.character
    private let bulk = AnimatedObject("vulto")
    
    private var gameStarted = false
    private var gameOver = false
    private var pausedGame = false
    private var givedUpGame = false
    private var colisionAllowed = true
    
    //Sprites do ambiente de jogo
    private var pausedButton: CustomizedButton? = nil
    private var ground: SKSpriteNode = SKSpriteNode()
    private var ceiling = SKSpriteNode()
    private var backgroundImage: SKSpriteNode = SKSpriteNode()
    
    let gameSKNode = SKNode()
    let objectDummy = SKNode()
    
    //Variável utilizada para auxiliar na lógica de movimento dos objetos
    private var movedActionOfObstacles = SKAction()
    private var obstaclesInAction = SKNode()
    
    override func didMove(to view: SKView) {
        //Relacionando o SKPhysicsContactDelegate à classe self
        self.physicsWorld.contactDelegate = self

        self.menu = Menu() {
            let telaInfo = Info(size: self.frame.size)
            telaInfo.scaleMode = .aspectFill
            
            //removendo pai do HighScore pois se não, quando voltar para essa tela, vai dar erro ao tentar adicionar um pai no HighScore ja que ele ja teria um
            Score.shared.scoreLabel.removeFromParent()
            //Removendo também das vidas do personagem
            self.character.characterToRemoveLifesFromParent()
            
            self.view?.presentScene(telaInfo, transition: SKTransition.fade(with: .black, duration: 1))
        }
        //Chamando a função que estrutura o menu principal
        self.menu!.menuToStruct(sizeView: self.size)
        
        //criando botão de pausar o game
        pauseButtonToCreate()
        self.pausedGameScreen = PausedGame(view: self)
        self.buttonsOfPausedScreenToCreate()
        
        Score.shared.scoreLabel.fontSize = 25
        Score.shared.scoreLabel.fontColor = .red
        Score.shared.scoreLabel.position = CGPoint(x: self.frame.width - 80, y: self.frame.height - 48)
        Score.shared.scoreLabel.zPosition = 2
        
        self.gameOverScreen = GameOver(view: self)
        self.gameOverScreen?.creatingRestartButton(view: self, actionOfBtnRestart: {
            self.givedUpGame = true
    
            self.obstaclesInAction.removeAllChildren()
            self.movedActionOfObstacles = SKAction.removeFromParent()
            self.obstaclesInAction.removeAllActions()
            self.removeAllActions()
            
            self.mostraMenu()
        })
        
        self.creatingAnimatedBackground()
        
        //Criando o objeto solo
        self.ground = groundToCreate(ground: SKSpriteNode(imageNamed: "chao"))
        self.ground.zPosition = 2
        
        //criando teto
        self.ceiling = self.ceilingToCreate(ceiling: self.ceiling)
        
        //Criando e chamando as funções que fazem a estrutura do personagem
        self.character.characterView = AnimatedObject("personagem_alma")
        self.character.characterView = character.characterToApplyProperties(character: character.characterView, view: self)
        self.character.characterView = character.characterToCollide(character: character.characterView)
        self.character.characterLife = character.characterLifeToSetProperties(characterLife: self.character.characterLife, view: self)
        
        self.bulk.setScale(0.2)
        self.bulk.position = CGPoint(x: 10, y: self.frame.height / 3)
        self.bulk.zPosition = 2
        
        self.hideLifeScoreAndPauseButton()
        
        //Adicionando os filhos para a gameSKNode
        self.gameSKNode.addChild(Score.shared.scoreLabel)
        self.gameSKNode.addChild(self.character.characterView)
        self.gameSKNode.addChild(self.bulk)
        self.gameSKNode.addChild(self.ceiling)
        self.gameSKNode.addChild(self.ground)
        self.gameSKNode.addChild(self.objectDummy)
        
        self.gameSKNode.addChild(self.pausedButton!)
        for life in self.character.characterLife {
            self.gameSKNode.addChild(life)
        }
        
        //Adicionando a SKNode do jogo na cena
        self.addChild(self.menu!)
        self.addChild(self.gameSKNode)
        self.addChild(self.pausedGameScreen!)
        self.addChild(self.gameOverScreen!)
    }
    
    //MARK: - Criando objetos da cena principal
    
    func deleteActionsAndObstacles() {
        self.movedActionOfObstacles = SKAction.removeFromParent()
        self.removeAllActions()
    }
    
    func restartLifeAndScore() -> Void {
        Score.shared.gameScore = 0

        for life in self.character.characterLife {
            life.removeFromParent()
        }
        
        self.character.characterLife.removeAll()
        self.character.characterLife = [SKSpriteNode(imageNamed: "caveira_vermelha"), SKSpriteNode(imageNamed: "caveira_vermelha"), SKSpriteNode(imageNamed: "caveira_vermelha")]
        self.character.characterLife = self.character.characterLifeToSetProperties(characterLife: self.character.characterLife, view: self)
        for life in self.character.characterLife {
            self.gameSKNode.addChild(life)
        }

    }
    
    func hideLifeScoreAndPauseButton() -> Void {
        Score.shared.scoreLabel.isHidden = true
        
        for life in self.character.characterLife {
            life.isHidden = true
        }
        
        self.pausedButton?.isHidden = true
    }
    
    func appearLifeScoreAndPauseButton() -> Void {
        Score.shared.scoreLabel.isHidden = false
        
        for life in self.character.characterLife {
            life.isHidden = false
        }
        
        self.pausedButton?.isHidden = false
    }
    
    func pauseButtonToCreate() -> Void {
        self.pausedButton = CustomizedButton(imageName: "pause.fill", buttonAction: {
            if !self.pausedGame {
                self.pausedGame = true
                self.pauseGameSKNode()
                self.pausedGameScreen!.isHidden = false
            }
            
        })
        self.pausedButton?.setScale(0.5)
        self.pausedButton?.zPosition = 2
        self.pausedButton?.position = CGPoint(x: self.frame.width - 40, y: self.frame.height - 40)
    }
    
    func pauseGameSKNode() -> Void {
        self.gameSKNode.isPaused = true
        
        self.character.characterView.physicsBody?.affectedByGravity = false
        self.character.characterView.physicsBody?.isDynamic = false
    }
    
    func continueGameSKNode() -> Void {
        self.gameSKNode.isPaused = false
        
        self.character.characterView.physicsBody?.affectedByGravity = true
        self.character.characterView.physicsBody?.isDynamic = true
    }
    
    func ceilingToCreate(ceiling: SKSpriteNode) -> SKSpriteNode {
        
        ceiling.size = CGSize(width: self.frame.width, height: 1)
        ceiling.position = CGPoint(x: self.frame.width / 2, y: self.frame.height)
        ceiling.zPosition = 0
        
        ceiling.physicsBody = SKPhysicsBody(rectangleOf: ceiling.size)
        ceiling.physicsBody?.categoryBitMask = PhysicsCategory.ceiling
        ceiling.physicsBody?.collisionBitMask = PhysicsCategory.character
        ceiling.physicsBody?.affectedByGravity = false
        ceiling.physicsBody?.isDynamic = false
        
        return ceiling
    }
    
    func groundToCreate(ground: SKSpriteNode) -> SKSpriteNode {
        ground.size = CGSize(width: self.frame.width, height: 60)
        ground.position = CGPoint(x: self.frame.width / 2, y: 30)
        ground.physicsBody = SKPhysicsBody(rectangleOf: ground.size)
        ground.physicsBody?.isDynamic = false
        ground.physicsBody?.affectedByGravity = false
        
        ground.physicsBody?.categoryBitMask = PhysicsCategory.ground
        ground.physicsBody?.collisionBitMask = PhysicsCategory.character | PhysicsCategory.obstacle
        ground.physicsBody?.contactTestBitMask = PhysicsCategory.character | PhysicsCategory.obstacle
        
        return ground
    }
    
    func buttonsOfPausedScreenToCreate() {
        self.pausedGameScreen!.creatingAllButtons(
            view: self,
            actionOfBtnGiveUp: {
                self.givedUpGame = true
        
                self.obstaclesInAction.removeAllChildren()
                self.obstaclesInAction.removeAllActions()
                self.deleteActionsAndObstacles()
                
                self.mostraMenu()
            },
            actionOfBtnContinue: {
                self.pausedGame = false
                self.continueGameSKNode()
                self.pausedGameScreen!.isHidden = true
            })
    }
    
    func mostraMenu() {
        self.menu!.tapToRestart()
        
        Score.shared.gameScore = 0
        
        self.gameStarted = false
        
        self.continueGameSKNode()
        self.pausedGame = false
        self.pausedGameScreen!.isHidden = true
        
        self.gameOverScreen?.isHidden = true
        
        self.restartLifeAndScore()
        self.hideLifeScoreAndPauseButton()
    }
    
    //Função que estrutura toda a parte do background animado
    func creatingAnimatedBackground() {
        let moveBackground = SKAction.moveBy(x: -self.size.width, y: 0, duration: 5)
        let resizeBackground = SKAction.moveBy(x: self.size.width, y: 0, duration: 0)
        let reDo = SKAction.repeatForever(SKAction.sequence([moveBackground, resizeBackground]))
        
        for i in 0..<2 {
            self.backgroundImage = SKSpriteNode(imageNamed: "bg")
            
            self.backgroundImage.anchorPoint = CGPoint(x: 0, y:0)
            
            self.backgroundImage.size.width = self.size.width * 2 //get the right pixel on phone
            self.backgroundImage.size.height = self.size.height
            self.backgroundImage.zPosition = 1 //Z positions define what itens comes in front goes from ex: 0,1,2,3 etc
            self.backgroundImage.position = CGPoint(x:self.size.width * CGFloat(i), y:0)
            self.backgroundImage.run(reDo)
            
            self.objectDummy.addChild(backgroundImage)
        }
        
        self.objectDummy.speed = 1
    }
    
    //Função utilizada para organizar melhor o código no switch case
    func settingPropertiesObstacle(obstacle: Obstacle, obstacleView: SKSpriteNode) -> SKSpriteNode {
        obstacle.obstacleView = obstacleView
    
        obstacle.obstacleView = obstacle.obstacleToSetSize(obstacle: obstacle.obstacleView)
        obstacle.obstacleView = obstacle.obstacleToSetPhysics(obstacle: obstacle.obstacleView)
        obstacle.obstacleView = obstacle.obstacleToCollide(obstacle: obstacle.obstacleView)
        
        return obstacleView
    }

    //
    func sortObstacle() -> Obstacle {
        let obstacleSorted = Int.random(in: 0...2)
        
        //Criando os objetos do tipo do obstaculo sorteado e setando as devidas propriedades
        switch obstacleSorted {
        case 0:
            let birdObstacle = BirdObstacle()
            birdObstacle.obstacleView = AnimatedObject("corvo")
            birdObstacle.obstacleView.setScale(0.15)
            birdObstacle.obstacleView.size = CGSize(width: 80, height: 45)
            birdObstacle.obstacleView = settingPropertiesObstacle(obstacle: birdObstacle, obstacleView: birdObstacle.obstacleView)
            
            let distance = CGFloat(self.frame.width + self.obstaclesInAction.frame.width)
            
            //Setando ação do obstáculo e colocando uma estrutura condicional que, conforme o jogo passa, vai ficando mais rápido e o objeto tem que ajustar mais para baixo, e é isso o que acontece
            if Score.shared.gameScore < 70 {
                birdObstacle.actionObstacle = SKAction.moveBy(x: -distance, y: -CGFloat(Int.random(in: 400...500)), duration: 0.004 * distance)
            } else {
                birdObstacle.actionObstacle = SKAction.moveBy(x: -distance, y: -CGFloat(Int.random(in: 500...600)), duration: 0.004 * distance)
            }
            
            
            birdObstacle.obstacleView.position.y = self.frame.height - CGFloat(Int.random(in: 50...100))
            return birdObstacle
        case 1:
            let tombstoneObstacle = TombstoneObstacle()
            tombstoneObstacle.obstacleView = SKSpriteNode(imageNamed: "lapide1")
            tombstoneObstacle.obstacleView.setScale(0.2)
            tombstoneObstacle.obstacleView.size = CGSize(width: 150, height: 90)
            tombstoneObstacle.obstacleView = settingPropertiesObstacle(obstacle: tombstoneObstacle, obstacleView: tombstoneObstacle.obstacleView)
            
            tombstoneObstacle.obstacleView.position.y = self.ground.frame.height + (tombstoneObstacle.obstacleView.frame.height / 2)
            return tombstoneObstacle
        case 2:
            let ghostObstacle = GhostObstacle()
            ghostObstacle.obstacleView = AnimatedObject("fantasma")
            ghostObstacle.obstacleView.setScale(0.15)
            ghostObstacle.obstacleView.size =  CGSize(width: 80, height: 80)
            ghostObstacle.obstacleView = settingPropertiesObstacle(obstacle: ghostObstacle, obstacleView: ghostObstacle.obstacleView)
            
            if Score.shared.gameScore < 70 {
                let distance = CGFloat(self.frame.width + self.obstaclesInAction.frame.width)
                ghostObstacle.actionObstacle = SKAction.moveBy(x: 0, y: (-self.frame.height / 1.5) + CGFloat(Int.random(in: -300...150)), duration: 0.004 * distance)
            } else {
                let distance = CGFloat(self.frame.width + self.obstaclesInAction.frame.width)
                ghostObstacle.actionObstacle = SKAction.moveBy(x: 0, y: (-self.frame.height / 1.5) + CGFloat(Int.random(in: -400...200)), duration: 0.004 * distance)
            }
            
            ghostObstacle.obstacleView.position.y = self.frame.height
            return ghostObstacle
        default:
            //Obstaculo poadrão
            let birdObstacle = BirdObstacle()
            birdObstacle.obstacleView.position.y = self.frame.height * 2
            return birdObstacle
        }
    }

    //Função que chama a função que gera os obstáculos, seta as propriedades dos mesmos e adiciona na cena
    func generatingNewObstacle() {
        if !givedUpGame && !pausedGame {
            self.obstaclesInAction = SKNode()
            let sortedObstacle = self.sortObstacle()
                        
            sortedObstacle.obstacleView.position.x = self.frame.width + (self.frame.width / 4)
                    
            sortedObstacle.obstacleView.physicsBody?.categoryBitMask = PhysicsCategory.obstacle
            sortedObstacle.obstacleView.physicsBody?.collisionBitMask = PhysicsCategory.character
            sortedObstacle.obstacleView.physicsBody?.contactTestBitMask = PhysicsCategory.character
            sortedObstacle.obstacleView.physicsBody?.affectedByGravity = false
            sortedObstacle.obstacleView.physicsBody?.isDynamic = false
                    
            sortedObstacle.obstacleView.run(sortedObstacle.actionObstacle)
            self.obstaclesInAction.addChild(sortedObstacle.obstacleView)
            
            self.obstaclesInAction.zPosition = 2
            self.obstaclesInAction.run(self.movedActionOfObstacles)
            self.gameSKNode.addChild(obstaclesInAction)
        }
    }
    
    func creatingMoveOfObstacle(tempo: Double, duration: Double) {
        let spawn = SKAction.run({ () in
            self.generatingNewObstacle()
        })
        
        let delay = SKAction.wait(forDuration: tempo)
        let spawnDelay = SKAction.sequence([spawn, delay])
        let spawnDelayForever = SKAction.repeatForever(spawnDelay)
        self.run(spawnDelayForever)
        
        let distance = CGFloat(self.frame.width + self.obstaclesInAction.frame.width)
        let movePipes = SKAction.moveBy(x: -distance - 300, y: 0, duration: duration * distance)
        let removePipes = SKAction.removeFromParent()
        self.movedActionOfObstacles = SKAction.sequence([movePipes, removePipes])
        
    }
    
    //Função que aguarda um tempo determinado para permitir com que o personagem possa colidir com os obstaculos
    func settingTimeOfInvincibility() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.colisionAllowed = true
        }
    }
    
    //Função que detecta o contato dos corpos
    func didBegin(_ contact: SKPhysicsContact) {
        let firstBody = contact.bodyA
        let secondBody = contact.bodyB
        
        if !givedUpGame {
            //Estrutura condicional que verifica os corpos de contato
            if firstBody.categoryBitMask == PhysicsCategory.character && secondBody.categoryBitMask == PhysicsCategory.obstacle || firstBody.categoryBitMask == PhysicsCategory.obstacle && secondBody.categoryBitMask == PhysicsCategory.character {
                
                
                
//                Decrementando itens da lista de vidas do jogo
                if self.colisionAllowed {
                    if !(self.character.characterLife.count <= 1) {
                        self.character.characterLife.last?.removeFromParent()
                        self.character.characterLife.removeLast()
                        
                        if menu!.audioStatus {
                            AVAudio.sharedInstance().playSoundEffect("impacto.mp3")
                        }
                    } else {
                        if !gameOver {

                            if menu!.audioStatus {
                                AVAudio.sharedInstance().playSoundEffect("gameover.mp3")
                            }

                            self.character.characterLife.last?.removeFromParent()
                            self.character.characterLife.removeLast()

                            self.gameOver = true
                            self.pausedGame = true
                            self.gameOverScreen!.isHidden = false
                            
                            self.pauseGameSKNode()
                            self.gameOverScreen?.updatingFinalScore(newFinalScore: Int(Score.shared.gameScore))
                            

                        }

                    }
                    
                    //Deixando a colisao permitida igual a false para o fator invencibilidade do personagem
                    self.colisionAllowed = false
                }
                self.settingTimeOfInvincibility()
                
                
                if firstBody.categoryBitMask == PhysicsCategory.obstacle {
                    firstBody.node?.removeFromParent()
                } else {
                    secondBody.node?.removeFromParent()
                }
            }
        }
        
    }
    

    
    
    
    func touchDown(atPoint pos : CGPoint) {
        
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !self.gameStarted {
            self.gameStarted = true
            self.givedUpGame = false
            self.gameOver = false
            
            self.appearLifeScoreAndPauseButton()
            self.menu!.tapToStart()
            self.creatingMoveOfObstacle(tempo: 2.5, duration: 0.004)
        } else {
            if !self.pausedGame {
                self.character.characterView = self.character.characterToFly(character: self.character.characterView)
            }
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        
    }
    
    //Criando função que implementa dificuldade com o decorrer do jogo
    func increasingLevel() {
        if Score.shared.gameScore == 10 {
            self.deleteActionsAndObstacles()
            self.creatingMoveOfObstacle(tempo: 2.0, duration: 0.0035)
        } else if Score.shared.gameScore == 30 {
            self.deleteActionsAndObstacles()
            self.creatingMoveOfObstacle(tempo: 1.8, duration: 0.0030)
        } else if Score.shared.gameScore == 70 {
            self.deleteActionsAndObstacles()
            self.creatingMoveOfObstacle(tempo: 1.5, duration: 0.0025)
        } else if Score.shared.gameScore == 130 {
            self.deleteActionsAndObstacles()
            self.creatingMoveOfObstacle(tempo: 1.0, duration: 0.0020)
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        if menu!.startGame == true{
            if !gameOver && !pausedGame {
                if currentTime > Score.shared.renderTime{
                    Score.shared.addScore()
                    Score.shared.trySaveHighScore()
                    Score.shared.scoreLabel.text = "\(Score.shared.gameScore)"
                    menu!.highScoreText.text = "\(Score.shared.highScore)"
                    Score.shared.renderTime = currentTime + Score.shared.changeTime
                    
                    self.increasingLevel()
                    
                }
            }
            
        }
    }
}
