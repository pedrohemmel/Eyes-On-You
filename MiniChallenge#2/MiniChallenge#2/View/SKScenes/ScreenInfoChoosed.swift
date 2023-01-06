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
        scrollView?.contentSize = CGSize(width: scrollView!.frame.width, height: scrollView!.frame.height * 3.5)
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
            
            let back = CustomizedButton(imageName: "back", buttonAction: {
                self.scrollView?.isDisabled = true
                let info = Info(size: self.frame.size)
                info.scaleMode = .aspectFill
                self.view?.presentScene(info, transition: SKTransition.fade(with: .black, duration: 1))
            })
            back.setScale(0.25)
            back.zPosition = 10.0
            back.position = CGPoint(x: frame.minX + 70, y: frame.maxY - 50)
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
            icon.position = CGPoint(x: frame.midX, y: frame.height - 50 )
            addChild(icon)
            
            let illustrations = SKLabelNode(fontNamed: "")
            illustrations.text = "Ilustrações e design".localizedLanguage()
            illustrations.fontSize = 20
            illustrations.position = CGPoint(x: frame.minX + 180, y: frame.height - 120)
            addChild(illustrations)
            
            let design = SKLabelNode(fontNamed: "")
            design.text = "Aline Reis Silva"
            design.fontSize = 16
            design.position = CGPoint(x: frame.minX + 149, y: frame.height - 150)
            addChild(design)
            
            let development = SKLabelNode(fontNamed: "")
            development.text = "Desenvolvedores".localizedLanguage()
            development.fontSize = 20
            development.position = CGPoint(x: frame.maxX - 260, y: frame.height - 120)
            addChild(development)
            
            let devs = SKLabelNode(fontNamed: "")
            devs.text = """
                        Gustavo Assis, Higor Crisostomo,
                        Marcelo Araujo e Pedro Henrique Souza.
                        """
            devs.fontSize = 16
            devs.preferredMaxLayoutWidth = 500
            devs.numberOfLines = 0
            devs.position = CGPoint(x: frame.midX + 205, y: frame.height - 173)
            addChild(devs)
            
            let soundTrack = SKLabelNode(fontNamed: "")
            soundTrack.text = "Trilha Sonora".localizedLanguage()
            soundTrack.fontSize = 20
            soundTrack.position = CGPoint(x: frame.minX + 140, y: frame.midY - 15)
            addChild(soundTrack)
            
            
            let firstLine = createLineSoundTrack(ccPos: CGPoint(x: frame.minX + 100, y: frame.midY - 50),
                                                 firstIconName: "cc_icon",
                                                 zeroPos: CGPoint(x: frame.minX + 135, y: frame.midY - 50),
                                                 secIconName: "zero_icon",
                                                 text: "052216 matsushima cemetery of pflanigan is licenced under CC0 1.0 Universal",
                                                 textPos: CGPoint(x: frame.midX + 18, y: frame.midY - 57))
            self.addChild(firstLine)
            
            
            let secLine = createLineSoundTrack(ccPos: CGPoint(x: frame.minX + 100, y: frame.midY - 80),
                                               firstIconName: "cc_icon",
                                               zeroPos: CGPoint(x: frame.minX + 135, y: frame.midY - 80),
                                               secIconName: "zero_icon",
                                               text: "Ghost Scream of onderwish is licenced under CC0 1.0 Universal",
                                               textPos: CGPoint(x: frame.midX - 33, y: frame.midY - 87))
            self.addChild(secLine)
            
            
            let terLine =  createLineSoundTrack(ccPos: CGPoint(x: frame.minX + 100, y: frame.midY - 110),
                                                firstIconName: "cc_icon",
                                                zeroPos: CGPoint(x: frame.minX + 135, y: frame.midY - 110),
                                                secIconName: "zero_icon",
                                                text: "Impacts of Anuj_Shrestha1 is licenced under CC0 1.0 Universal",
                                                textPos: CGPoint(x: frame.midX - 33, y: frame.midY - 117))
             self.addChild(terLine)
            
            
            let forLine = createLineSoundTrack(ccPos: CGPoint(x: frame.minX + 100, y: frame.midY - 140),
                                               firstIconName: "cc_icon",
                                               zeroPos: CGPoint(x: frame.minX + 135, y: frame.midY - 140),
                                               secIconName: "person_icon",
                                               text: "The Cemetery of TheRedLetterDay is licenced under CC BY 4.0",
                                               textPos: CGPoint(x: frame.midX - 33, y: frame.midY - 147))
            self.addChild(forLine)

        }
        
        func iconsCC(firstIcon: CGPoint, firstIconName: String, secIcon: CGPoint, secIconName: String ) -> [SKSpriteNode] {
            let ccIcon = SKSpriteNode(imageNamed: firstIconName)
            ccIcon.setScale(0.85)
            ccIcon.zPosition = 10.0
            ccIcon.position = firstIcon
            
            let zeroIcon = SKSpriteNode(imageNamed: secIconName)
            zeroIcon.setScale(0.85)
            zeroIcon.zPosition = 10.0
            zeroIcon.position = secIcon
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
            txt.position = textPos
            line.addChild(txt)
            return line
        }
        
        func setupPolitcs(){
            let title = SKLabelNode(fontNamed: "")
            title.fontSize = 20
            title.position = CGPoint(x: frame.midX, y: frame.maxY - 60)
            title.preferredMaxLayoutWidth = frame.width * 0.8
            title.lineBreakMode = NSLineBreakMode.byWordWrapping
            title.numberOfLines = 0
            title.text = "Políticas de privacidade".localizedLanguage()
            
            let textBoddy = SKLabelNode(fontNamed: "")

            textBoddy.fontSize = 16
            textBoddy.position = CGPoint(x: frame.midX , y: frame.minY - frame.height * 2)
            textBoddy.preferredMaxLayoutWidth = frame.width * 0.78
            textBoddy.lineBreakMode = NSLineBreakMode.byWordWrapping
            textBoddy.numberOfLines = 0
            textBoddy.text = "Aline Reis, Gustavo Oliveira, Higor Crisostomo, Marcelo Araujo e Pedro Hemmel  criou o aplicativo Eyes on you como um aplicativo gratuito. Este SERVIÇO é fornecido por Aline Reis, Gustavo Oliveira, Higor Crisostomo, Marcelo Araujo e Pedro Hemmel sem nenhum custo e destina-se ao uso como está. Esta página é usada para informar os visitantes sobre minhas políticas de coleta, uso e divulgação de informações pessoais, caso alguém decida usar meu serviço. Se você optar por usar meu serviço, concorda com a coleta e o uso de informações relacionadas a esta política. As Informações Pessoais que eu coleto são usadas para fornecer e melhorar o Serviço. Não usarei ou compartilharei suas informações com ninguém, exceto conforme descrito nesta Política de Privacidade. Os termos usados nesta Política de Privacidade têm os mesmos significados que em nossos Termos e Condições, que podem ser acessados em Eyes on you, a menos que definido de outra forma nesta Política de Privacidade. Coleta e uso de informações Para uma melhor experiência ao usar nosso Serviço, posso exigir que você nos forneça algumas informações de identificação pessoal. As informações que solicito serão mantidas em seu dispositivo e não serão coletadas por mim de forma alguma. Log Data Quero informar que sempre que você usa meu Serviço, em caso de erro no app eu coleto dados e informações (através de produtos de terceiros) em seu telefone chamado Log Data. Esses dados de registro podem incluir informações como endereço de protocolo de Internet (IP) do dispositivo, nome do dispositivo, versão do sistema operacional, configuração do aplicativo ao utilizar meu serviço, hora e data de uso do serviço e outras estatísticas . Cookies Cookies são arquivos com uma pequena quantidade de dados que são comumente usados como identificadores únicos anônimos. Estes são enviados para o seu navegador a partir dos sites que você visita e são armazenados na memória interna do seu dispositivo. Este Serviço não usa esses “cookies” explicitamente. No entanto, o aplicativo pode usar código e bibliotecas de terceiros que usam cookies para coletar informações e melhorar seus serviços. Você tem a opção de aceitar ou recusar esses cookies e saber quando um cookie está sendo enviado ao seu dispositivo. Se você optar por recusar nossos cookies, talvez não consiga usar algumas partes deste Serviço. Provedores de Serviços Posso contratar empresas e indivíduos terceirizados pelos seguintes motivos: Para facilitar nosso Serviço; Para fornecer o Serviço em nosso nome; Para realizar serviços relacionados ao Serviço; ou Para nos ajudar a analisar como nosso Serviço é usado. Desejo informar aos usuários deste Serviço que esses terceiros têm acesso às suas Informações Pessoais. O motivo é realizar as tarefas atribuídas a eles em nosso nome. No entanto, eles são obrigados a não divulgar ou usar as informações para qualquer outra finalidade. Segurança Eu valorizo sua confiança em nos fornecer suas informações pessoais, portanto, estamos nos esforçando para usar meios comercialmente aceitáveis de protegê-las. Mas lembre-se que nenhum método de transmissão pela internet, ou método de armazenamento eletrônico é 100% seguro e confiável, e não posso garantir sua segurança absoluta. Links para outros sites Este serviço pode conter links para outros sites. Se você clicar em um link de terceiros, será direcionado para esse site. Observe que esses sites externos não são operados por mim. Portanto, aconselho fortemente que você revise a Política de Privacidade desses sites. Não tenho controle e não assumo nenhuma responsabilidade pelo conteúdo, políticas de privacidade ou práticas de sites ou serviços de terceiros. Privacidade das crianças Não coleto intencionalmente informações de identificação pessoal de crianças. Encorajo todas as crianças a nunca enviar nenhuma informação de identificação pessoal por meio do Aplicativo e/ou Serviços. Encorajo os pais e responsáveis legais a monitorar o uso da Internet por seus filhos e a ajudar a aplicar esta Política, instruindo seus filhos a nunca fornecer informações de identificação pessoal por meio do Aplicativo e/ou Serviços sem a permissão deles. Se você tiver motivos para acreditar que uma criança nos forneceu informações de identificação pessoal por meio do Aplicativo e/ou Serviços, entre em contato conosco. Você também deve ter pelo menos 16 anos de idade para consentir com o processamento de suas informações de identificação pessoal em seu país (em alguns países, podemos permitir que seus pais ou responsáveis o façam em seu nome). Alterações nesta Política de Privacidade Posso atualizar nossa Política de Privacidade de tempos em tempos. Assim, você é aconselhado a revisar esta página periodicamente para quaisquer alterações. Vou notificá-lo sobre quaisquer alterações, publicando a nova Política de Privacidade nesta página. Esta política é efetiva a partir de 2022-11-25 Contate-nos Se você tiver alguma dúvida ou sugestão sobre minha Política de Privacidade, não hesite em entrar em contato comigo em eyesonyouapp@gmail.com. Esta página de política de privacidade foi criada em privacypolicytemplate.net e modificada/gerada pelo App Privacy Policy Generator.".localizedLanguage()
            
            moveableNode.addChild(title)
            moveableNode.addChild(textBoddy)
            
        }
        
        func setupTerms(){
            let title = SKLabelNode(fontNamed: "")
            title.fontSize = 20
            title.position = CGPoint(x: frame.midX, y: frame.maxY - 60)
            title.preferredMaxLayoutWidth = frame.width * 0.8
            title.lineBreakMode = NSLineBreakMode.byWordWrapping
            title.numberOfLines = 0
            title.text = "Termos de Uso".localizedLanguage()
            
            
//            title.text = "Termos de Uso".localizedLanguage()
            
            let textBoddy = SKLabelNode(fontNamed: "")
            textBoddy.fontSize = 16
            textBoddy.position = CGPoint(x: frame.midX , y: frame.minY - frame.height * 2.3)
            textBoddy.preferredMaxLayoutWidth = frame.width * 0.78
            textBoddy.lineBreakMode = NSLineBreakMode.byWordWrapping
            textBoddy.numberOfLines = 0
            textBoddy.text = "Ao fazer o download ou usar o aplicativo, estes termos se aplicarão automaticamente a você - portanto, certifique-se de lê-los cuidadosamente antes de usar o aplicativo. Você não tem permissão para copiar ou modificar o aplicativo, qualquer parte do aplicativo ou nossas marcas registradas de forma alguma. Você não tem permissão para tentar extrair o código-fonte do aplicativo e também não deve tentar traduzir o aplicativo para outros idiomas ou fazer versões derivadas. O aplicativo em si e todas as marcas registradas, direitos autorais, direitos de banco de dados e outros direitos de propriedade intelectual relacionados a ele, ainda pertencem a Aline Reis, Gustavo Oliveira, Higor Crisostomo, Marcelo Araujo e Pedro Hemmel. Aline Reis, Gustavo Oliveira, Higor Crisostomo, Marcelo Araujo e Pedro Hemmel tem o compromisso de garantir que o aplicativo seja o mais útil e eficiente possível. Por esse motivo, nos reservamos o direito de fazer alterações no aplicativo ou cobrar por seus serviços, a qualquer momento e por qualquer motivo. Nunca cobraremos pelo aplicativo ou seus serviços sem torná-lo ve ry claro para você exatamente o que você está pagando. O aplicativo Eyes on you armazena e processa dados pessoais que você nos forneceu para fornecer meu Serviço. É sua responsabilidade manter seu telefone e acesso ao aplicativo seguros. Portanto, recomendamos que você não faça jailbreak ou root em seu telefone, que é o processo de remoção de restrições e limitações de software impostas pelo sistema operacional oficial do seu dispositivo. Isso pode tornar seu telefone vulnerável a malware/vírus/programas maliciosos, comprometer os recursos de segurança do seu telefone e pode significar que o aplicativo Eyes on you não funcionará corretamente ou não funcionará. Você deve estar ciente de que há certas coisas pelas quais Aline Reis, Gustavo Oliveira, Higor Crisostomo, Marcelo Araujo e Pedro Hemmel não se responsabilizarão. Certas funções do aplicativo exigirão que o aplicativo tenha uma conexão ativa com a Internet. A conexão pode ser Wi-Fi ou fornecida pelo seu provedor de rede móvel, mas Aline Reis, Gustavo Oliveira, Higor Crisostomo, Marcelo Araujo e Pedro Hemmel não podem se responsabilizar pelo aplicativo não funcionar com todas as funcionalidades se você não tiver acesso ao Wi -Fi, e você não tem nenhuma permissão de dados sobrando. Se você estiver usando o aplicativo fora de uma área com Wi-Fi, lembre-se de que os termos do contrato com sua operadora de rede móvel ainda serão aplicados. Como resultado, você pode ser cobrado por sua operadora de celular pelo custo dos dados durante a conexão durante o acesso ao aplicativo ou outras cobranças de terceiros. Ao usar o aplicativo, você aceita a responsabilidade por tais cobranças, incluindo cobranças de dados de roaming se você usar o aplicativo fora de seu território de origem (ou seja, região ou país) sem desativar o roaming de dados. Se você não for o pagador da conta do dispositivo no qual está usando o aplicativo, saiba que presumimos que você recebeu permissão do pagador para usar o aplicativo. Na mesma linha, Aline Reis, Gustavo Oliveira, Higor Crisostomo, Marcelo Araujo e Pedro Hemmel nem sempre podem se responsabilizar pela forma como você usa o app, ou seja, você precisa se certificar de que seu aparelho está carregado – caso fique sem bateria e você não pode ativá-lo para usufruir do Serviço, Aline Reis, Gustavo Oliveira, Higor Crisóstomo, Marcelo Araujo e Pedro Hemmel não podem aceitar a responsabilidade. No que diz respeito à responsabilidade de Aline Reis, Gustavo Oliveira, Higor Crisostomo, Marcelo Araujo e Pedro Hemmel pelo uso do aplicativo, quando você estiver usando o aplicativo, é importante ter em mente que, embora nos esforcemos para garantir que ele esteja atualizado e corretas o tempo todo, dependemos de terceiros para nos fornecer informações para que possamos disponibilizá-las a você. Aline Reis, Gustavo Oliveira, Higor Crisostomo, Marcelo Araujo e Pedro Hemmel não se responsabilizam por qualquer perda, direta ou indireta, que você sofra como resultado de confiar totalmente nesta funcionalidade do aplicativo. Em algum momento, podemos desejar atualizar o aplicativo. O aplicativo está atualmente disponível no iOS - os requisitos para o sistema (e para quaisquer sistemas adicionais para os quais decidimos estender a disponibilidade do aplicativo) podem mudar e você precisará baixar as atualizações se quiser continuar usando o aplicativo. Aline Reis, Gustavo Oliveira, Higor Crisostomo, Marcelo Araujo e Pedro Hemmel não promete que sempre atualizará o aplicativo para que seja relevante para você e/ou funcione com a versão do iOS que você instalou em seu dispositivo. No entanto, você promete sempre aceitar as atualizações do aplicativo quando oferecidas a você. Também podemos interromper o fornecimento do aplicativo e encerrar o uso dele a qualquer momento, sem avisar você. A menos que digamos o contrário, após qualquer rescisão, (a) os direitos e licenças concedidos a você nestes termos terminarão; (b) você deve parar de usar o aplicativo e (se necessário) excluí-lo do seu dispositivo. Alterações a estes Termos e Condições Posso atualizar nossos Termos e Condições de tempos em tempos. Assim, você é aconselhado a revisar esta página periodicamente para quaisquer alterações. Vou notificá-lo sobre quaisquer alterações, publicando os novos Termos e Condições nesta página. Estes termos e condições são válidos a partir de 2022-11-25 Contate-nos Se você tiver alguma dúvida ou sugestão sobre meus Termos e Condições, não hesite em entrar em contato comigo em eyesonyouapp@gmail.com. Esta página de Termos e Condições foi gerada pelo App Privacy Policy Generator".localizedLanguage()
            
            moveableNode.addChild(title)
            moveableNode.addChild(textBoddy)
            
            
        }
    }
    

