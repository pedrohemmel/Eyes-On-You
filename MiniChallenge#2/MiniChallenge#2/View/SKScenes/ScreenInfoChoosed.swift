//
//  CenaTeste.swift
//  MiniChallenge#2
//
//  Created by Gustavo Assis on 30/11/22.
//

import SpriteKit
import Foundation
import SwiftySKScrollView

class ScreenInfoChoosed : SKScene {
    public var tela: Int
    
    var scrollView: SwiftySKScrollView?
    let moveableNode = SKNode()

    
    //MARK: - Systems
    
    override func didMove(to view: SKView) {
        addChild(moveableNode)
        scrollView = SwiftySKScrollView(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height), moveableNode: moveableNode, direction: .vertical)
        scrollView?.contentSize = CGSize(width: scrollView!.frame.width, height: scrollView!.frame.height * 4.8)
        view.addSubview(scrollView!)
    }
    
    override func sceneDidLoad() {
        setupNodes()
        setupBG()
        chooseScreen(tela: tela)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(tela: Int, size: CGSize) {
        self.tela = tela
        super.init(size: size)
    }
}
    
    //MARK: - Configurations
    
    extension ScreenInfoChoosed {
        
        func setupBG() {
            let bgNode = SKSpriteNode(color: UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1), size: CGSize(width: frame.width, height: frame.height))
            bgNode.zPosition = -1.0
            bgNode.anchorPoint = .zero
            bgNode.position = .zero
            addChild(bgNode)
        }
        
        func setupNodes() {
            
            let back = CustomizedButton(imageName: "back", lblText: nil, buttonAction: {
                self.scrollView?.isDisabled = true
                let info = Info(size: self.frame.size)
                info.scaleMode = .aspectFill
                self.view?.presentScene(info, transition: SKTransition.fade(with: .black, duration: 1))
            })
            back.setScale(0.25)
            back.zPosition = 10.0
            back.position = CGPoint(x: frame.width / 12, y: frame.height - (frame.height / 7))
            addChild(back)
        }
        
        func chooseScreen(tela: Int){
            
            switch tela {
                case 2:
                    setupCredits()
                case 3:
                    setupPolitcs()
                default:
                    setupTerms()
            }
        }
        

        func setupCredits(){
            
            let icon = SKSpriteNode(imageNamed: "cc")
            icon.setScale(1.1)
            icon.zPosition = 10.0
            icon.position = CGPoint(x: frame.midX, y: frame.height - (frame.height / 7))
            addChild(icon)
            
            let illustrations = SKLabelNode(fontNamed: "")
            illustrations.text = "Illustrations and Design".localizedLanguage()
            illustrations.fontSize = 20
            illustrations.position = CGPoint(x: frame.width / 12 + (illustrations.frame.width / 2), y: frame.height - (frame.height / 3))
            addChild(illustrations)
            
            let design = SKLabelNode(fontNamed: "")
            design.text = "Aline Reis Silva"
            design.fontSize = 16
            design.position = CGPoint(x: frame.width / 12 + (design.frame.width / 2), y: frame.height - (frame.height / 2.5))
            addChild(design)
            
            let development = SKLabelNode(fontNamed: "")
            development.text = "Development".localizedLanguage()
            development.fontSize = 20
            development.position = CGPoint(x: frame.width - (frame.width / 2) + (development.frame.width / 2), y: frame.height - (frame.height / 3))
            addChild(development)
            
            let devs = SKLabelNode(fontNamed: "")
            devs.text = """
                        Gustavo Assis, Higor Crisostomo,
                        Marcelo Araujo e Pedro Henrique Souza.
                        """
            devs.fontSize = 16
            devs.preferredMaxLayoutWidth = 500
            devs.numberOfLines = 0
            devs.preferredMaxLayoutWidth = frame.width - (frame.width / 5)
            devs.position = CGPoint(x: frame.width - (frame.width / 2) + (devs.frame.width / 2), y: frame.height - (frame.height / 2.5) - (devs.frame.height / 2))
            addChild(devs)
            
            let soundTrack = SKLabelNode(fontNamed: "")
            soundTrack.text = "Soundtrack".localizedLanguage()
            soundTrack.fontSize = 20
            soundTrack.position = CGPoint(x: frame.width / 12 + (soundTrack.frame.width / 2), y: frame.height - (frame.height / 1.85))
            addChild(soundTrack)
            
            
            let firstLine = createLineSoundTrack(ccPos: CGPoint(x: frame.width / 12, y: frame.height - (frame.height / 1.65)),
                                                 firstIconName: "cc_icon",
                                                 zeroPos: CGPoint(x: frame.width / 8, y: frame.height - (frame.height / 1.65)),
                                                 secIconName: "zero_icon",
                                                 text: "052216 matsushima cemetery of pflanigan is licenced under CC0 1.0 Universal",
                                                 textPos: CGPoint(x: frame.width / 6 , y: frame.height - (frame.height / 1.65)))
            self.addChild(firstLine)
            
            
            let secLine = createLineSoundTrack(ccPos: CGPoint(x: frame.width / 12, y: frame.height - (frame.height / 1.45)),
                                               firstIconName: "cc_icon",
                                               zeroPos: CGPoint(x: frame.width / 8, y: frame.height - (frame.height / 1.45)),
                                               secIconName: "zero_icon",
                                               text: "Ghost Scream of onderwish is licenced under CC0 1.0 Universal",
                                               textPos: CGPoint(x: frame.width / 6 , y: frame.height - (frame.height / 1.45)))
            self.addChild(secLine)
            
            
            let terLine =  createLineSoundTrack(ccPos: CGPoint(x: frame.width / 12, y: frame.height - (frame.height / 1.3)),
                                                firstIconName: "cc_icon",
                                                zeroPos: CGPoint(x: frame.width / 8, y: frame.height - (frame.height / 1.3)),
                                                secIconName: "zero_icon",
                                                text: "Impacts of Anuj_Shrestha1 is licenced under CC0 1.0 Universal",
                                                textPos: CGPoint(x: frame.width / 6 , y: frame.height - (frame.height / 1.3)))
             self.addChild(terLine)
            
            
            let forLine = createLineSoundTrack(ccPos: CGPoint(x: frame.width / 12, y: frame.height - (frame.height / 1.175)),
                                               firstIconName: "cc_icon",
                                               zeroPos: CGPoint(x: frame.width / 8, y: frame.height - (frame.height / 1.175)),
                                               secIconName: "person_icon",
                                               text: "The Cemetery of TheRedLetterDay is licenced under CC BY 4.0",
                                               textPos: CGPoint(x: frame.width / 6 , y: frame.height - (frame.height / 1.175)))
            self.addChild(forLine)

        }
        
        func iconsCC(firstIcon: CGPoint, firstIconName: String, secIcon: CGPoint, secIconName: String ) -> [SKSpriteNode] {
            let ccIcon = SKSpriteNode(imageNamed: firstIconName)
            ccIcon.setScale(0.85)
            ccIcon.zPosition = 10.0
            ccIcon.position = CGPoint(x: firstIcon.x + (ccIcon.frame.width / 2), y: firstIcon.y)
            
            let zeroIcon = SKSpriteNode(imageNamed: secIconName)
            zeroIcon.setScale(0.85)
            zeroIcon.zPosition = 10.0
            zeroIcon.position = CGPoint(x: secIcon.x + (zeroIcon.frame.width / 2), y: secIcon.y)
            return [ccIcon, zeroIcon]
        }
        
        func createLineSoundTrack(ccPos: CGPoint, firstIconName: String, zeroPos: CGPoint, secIconName: String, text: String, textPos: CGPoint) -> SKNode {
            let line = SKNode()
            for i in iconsCC(firstIcon: ccPos, firstIconName: firstIconName, secIcon: zeroPos, secIconName: secIconName) {
                line.addChild(i)
            }
            
            let txt = SKLabelNode(fontNamed: "")
            txt.text = text
            txt.fontSize = 15
            line.addChild(txt)
            txt.position = CGPoint(x: textPos.x + txt.frame.width / 2, y: textPos.y - (txt.frame.height / 2))
            return line
        }
        
        func setupPolitcs(){
            let title = SKLabelNode(fontNamed: "")
            title.text = "Privacy Policies".localizedLanguage()
            title.fontSize = 20
            title.preferredMaxLayoutWidth = frame.width * 0.8
            title.lineBreakMode = NSLineBreakMode.byWordWrapping
            title.numberOfLines = 0
            
            let textBoddy = SKLabelNode(fontNamed: "")
            textBoddy.text = "Aline Reis, Gustavo Oliveira, Higor Crisostomo, Marcelo Araujo e Pedro Hemmel  criou o aplicativo Eyes on you como um aplicativo gratuito. Este SERVIÇO é fornecido por Aline Reis, Gustavo Oliveira, Higor Crisostomo, Marcelo Araujo e Pedro Hemmel sem nenhum custo e destina-se ao uso como está. Esta página é usada para informar os visitantes sobre minhas políticas de coleta, uso e divulgação de informações pessoais, caso alguém decida usar meu serviço. Se você optar por usar meu serviço, concorda com a coleta e o uso de informações relacionadas a esta política. As Informações Pessoais que eu coleto são usadas para fornecer e melhorar o Serviço. Não usarei ou compartilharei suas informações com ninguém, exceto conforme descrito nesta Política de Privacidade. Os termos usados nesta Política de Privacidade têm os mesmos significados que em nossos Termos e Condições, que podem ser acessados em Eyes on you, a menos que definido de outra forma nesta Política de Privacidade. Coleta e uso de informações Para uma melhor experiência ao usar nosso Serviço, posso exigir que você nos forneça algumas informações de identificação pessoal. As informações que solicito serão mantidas em seu dispositivo e não serão coletadas por mim de forma alguma. Log Data Quero informar que sempre que você usa meu Serviço, em caso de erro no app eu coleto dados e informações (através de produtos de terceiros) em seu telefone chamado Log Data. Esses dados de registro podem incluir informações como endereço de protocolo de Internet (IP) do dispositivo, nome do dispositivo, versão do sistema operacional, configuração do aplicativo ao utilizar meu serviço, hora e data de uso do serviço e outras estatísticas . Cookies Cookies são arquivos com uma pequena quantidade de dados que são comumente usados como identificadores únicos anônimos. Estes são enviados para o seu navegador a partir dos sites que você visita e são armazenados na memória interna do seu dispositivo. Este Serviço não usa esses “cookies” explicitamente. No entanto, o aplicativo pode usar código e bibliotecas de terceiros que usam cookies para coletar informações e melhorar seus serviços. Você tem a opção de aceitar ou recusar esses cookies e saber quando um cookie está sendo enviado ao seu dispositivo. Se você optar por recusar nossos cookies, talvez não consiga usar algumas partes deste Serviço. Provedores de Serviços Posso contratar empresas e indivíduos terceirizados pelos seguintes motivos: Para facilitar nosso Serviço; Para fornecer o Serviço em nosso nome; Para realizar serviços relacionados ao Serviço; ou Para nos ajudar a analisar como nosso Serviço é usado. Desejo informar aos usuários deste Serviço que esses terceiros têm acesso às suas Informações Pessoais. O motivo é realizar as tarefas atribuídas a eles em nosso nome. No entanto, eles são obrigados a não divulgar ou usar as informações para qualquer outra finalidade. Segurança Eu valorizo sua confiança em nos fornecer suas informações pessoais, portanto, estamos nos esforçando para usar meios comercialmente aceitáveis de protegê-las. Mas lembre-se que nenhum método de transmissão pela internet, ou método de armazenamento eletrônico é 100% seguro e confiável, e não posso garantir sua segurança absoluta. Links para outros sites Este serviço pode conter links para outros sites. Se você clicar em um link de terceiros, será direcionado para esse site. Observe que esses sites externos não são operados por mim. Portanto, aconselho fortemente que você revise a Política de Privacidade desses sites. Não tenho controle e não assumo nenhuma responsabilidade pelo conteúdo, políticas de privacidade ou práticas de sites ou serviços de terceiros. Privacidade das crianças Não coleto intencionalmente informações de identificação pessoal de crianças. Encorajo todas as crianças a nunca enviar nenhuma informação de identificação pessoal por meio do Aplicativo e/ou Serviços. Encorajo os pais e responsáveis legais a monitorar o uso da Internet por seus filhos e a ajudar a aplicar esta Política, instruindo seus filhos a nunca fornecer informações de identificação pessoal por meio do Aplicativo e/ou Serviços sem a permissão deles. Se você tiver motivos para acreditar que uma criança nos forneceu informações de identificação pessoal por meio do Aplicativo e/ou Serviços, entre em contato conosco. Você também deve ter pelo menos 16 anos de idade para consentir com o processamento de suas informações de identificação pessoal em seu país (em alguns países, podemos permitir que seus pais ou responsáveis o façam em seu nome). Alterações nesta Política de Privacidade Posso atualizar nossa Política de Privacidade de tempos em tempos. Assim, você é aconselhado a revisar esta página periodicamente para quaisquer alterações. Vou notificá-lo sobre quaisquer alterações, publicando a nova Política de Privacidade nesta página. Esta política é efetiva a partir de 2022-11-25 Contate-nos Se você tiver alguma dúvida ou sugestão sobre minha Política de Privacidade, não hesite em entrar em contato comigo em eyesonyouapp@gmail.com. Esta página de política de privacidade foi criada em privacypolicytemplate.net e modificada/gerada pelo App Privacy Policy Generator.".localizedLanguage()
            textBoddy.fontSize = 16
            textBoddy.preferredMaxLayoutWidth = frame.width * 0.78
            textBoddy.lineBreakMode = NSLineBreakMode.byWordWrapping
            textBoddy.numberOfLines = 0
            
            moveableNode.addChild(title)
            moveableNode.addChild(textBoddy)
            title.position = CGPoint(x: frame.midX, y: frame.height - (frame.height / 6))
            textBoddy.position = CGPoint(x: frame.midX , y: frame.height - (frame.height / 5) - textBoddy.frame.height)
        }
        
        func setupTerms(){
            let title = SKLabelNode(fontNamed: "")
            title.text = "Terms of use".localizedLanguage()
            title.fontSize = 20
            title.preferredMaxLayoutWidth = frame.width * 0.8
            title.lineBreakMode = NSLineBreakMode.byWordWrapping
            title.numberOfLines = 0
            
            let textBoddy = SKLabelNode(fontNamed: "")
            textBoddy.text = "By downloading or using the app, these terms will automatically apply to you – you should make sure therefore that you read them carefully before using the app. You’re not allowed to copy or modify the app, any part of the app, or our trademarks in any way. You’re not allowed to attempt to extract the source code of the app, and you also shouldn’t try to translate the app into other languages or make derivative versions. The app itself, and all the trademarks, copyright, database rights, and other intellectual property rights related to it, still belong to Aline Reis, Gustavo Oliveira, Higor Crisostomo, Marcelo Araujo e Pedro Hemmel. Aline Reis, Gustavo Oliveira, Higor Crisostomo, Marcelo Araujo e Pedro Hemmel is committed to ensuring that the app is as useful and efficient as possible. For that reason, we reserve the right to make changes to the app or to charge for its services, at any time and for any reason. We will never charge you for the app or its services without making it very clear to you exactly what you’re paying for. The Eyes on you app stores and processes personal data that you have provided to us, to provide my Service. It’s your responsibility to keep your phone and access to the app secure. We therefore recommend that you do not jailbreak or root your phone, which is the process of removing software restrictions and limitations imposed by the official operating system of your device. It could make your phone vulnerable to malware/viruses/malicious programs, compromise your phone’s security features and it could mean that the Eyes on you app won’t work properly or at all. You should be aware that there are certain things that Aline Reis, Gustavo Oliveira, Higor Crisostomo, Marcelo Araujo e Pedro Hemmel will not take responsibility for. Certain functions of the app will require the app to have an active internet connection. The connection can be Wi-Fi or provided by your mobile network provider, but Aline Reis, Gustavo Oliveira, Higor Crisostomo, Marcelo Araujo e Pedro Hemmel cannot take responsibility for the app not working at full functionality if you don’t have access to Wi-Fi, and you don’t have any of your data allowance left. If you’re using the app outside of an area with Wi-Fi, you should remember that the terms of the agreement with your mobile network provider will still apply. As a result, you may be charged by your mobile provider for the cost of data for the duration of the connection while accessing the app, or other third-party charges. In using the app, you’re accepting responsibility for any such charges, including roaming data charges if you use the app outside of your home territory (i.e. region or country) without turning off data roaming. If you are not the bill payer for the device on which you’re using the app, please be aware that we assume that you have received permission from the bill payer for using the app. Along the same lines, Aline Reis, Gustavo Oliveira, Higor Crisostomo, Marcelo Araujo e Pedro Hemmel cannot always take responsibility for the way you use the app i.e. You need to make sure that your device stays charged – if it runs out of battery and you can’t turn it on to avail the Service, Aline Reis, Gustavo Oliveira, Higor Crisostomo, Marcelo Araujo e Pedro Hemmel cannot accept responsibility. With respect to Aline Reis, Gustavo Oliveira, Higor Crisostomo, Marcelo Araujo e Pedro Hemmel’s responsibility for your use of the app, when you’re using the app, it’s important to bear in mind that although we endeavor to ensure that it is updated and correct at all times, we do rely on third parties to provide information to us so that we can make it available to you. Aline Reis, Gustavo Oliveira, Higor Crisostomo, Marcelo Araujo e Pedro Hemmel accepts no liability for any loss, direct or indirect, you experience as a result of relying wholly on this functionality of the app. At some point, we may wish to update the app. The app is currently available on iOS – the requirements for the system(and for any additional systems we decide to extend the availability of the app to) may change, and you’ll need to download the updates if you want to keep using the app. Aline Reis, Gustavo Oliveira, Higor Crisostomo, Marcelo Araujo e Pedro Hemmel does not promise that it will always update the app so that it is relevant to you and/or works with the iOS version that you have installed on your device. However, you promise to always accept updates to the application when offered to you, We may also wish to stop providing the app, and may terminate use of it at any time without giving notice of termination to you. Unless we tell you otherwise, upon any termination, (a) the rights and licenses granted to you in these terms will end; (b) you must stop using the app, and (if needed) delete it from your device. Changes to This Terms and Conditions I may update our Terms and Conditions from time to time. Thus, you are advised to review this page periodically for any changes. I will notify you of any changes by posting the new Terms and Conditions on this page. These terms and conditions are effective as of 2022-11-25 Contact Us If you have any questions or suggestions about my Terms and Conditions, do not hesitate to contact me at eyesonyouapp@gmail.com. This Terms and Conditions page was generated by App Privacy Policy Generator".localizedLanguage()
            textBoddy.fontSize = 16
            textBoddy.preferredMaxLayoutWidth = frame.width * 0.78
            textBoddy.lineBreakMode = NSLineBreakMode.byWordWrapping
            textBoddy.numberOfLines = 0
            
            moveableNode.addChild(title)
            moveableNode.addChild(textBoddy)
            title.position = CGPoint(x: frame.midX, y: frame.height - (frame.height / 6))
            textBoddy.position = CGPoint(x: frame.midX , y: frame.height - (frame.height / 5) - textBoddy.frame.height)
        }
        
    }
    

