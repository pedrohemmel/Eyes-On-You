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
            illustrations.text = "Illustrations and design".localizedLanguage()
            illustrations.fontSize = 20
            illustrations.position = CGPoint(x: frame.minX + 180, y: frame.height - 120)
            addChild(illustrations)
            
            let design = SKLabelNode(fontNamed: "")
            design.text = "Aline Reis Silva"
            design.fontSize = 16
            design.position = CGPoint(x: frame.minX + 149, y: frame.height - 150)
            addChild(design)
            
            let development = SKLabelNode(fontNamed: "")
            development.text = "Development".localizedLanguage()
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
            soundTrack.text = "Soundtrack"
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
            title.text = "Privacy Policies".localizedLanguage()
            
            let textBoddy = SKLabelNode(fontNamed: "")

            textBoddy.fontSize = 16
            textBoddy.position = CGPoint(x: frame.midX , y: frame.minY - frame.height * 2)
            textBoddy.preferredMaxLayoutWidth = frame.width * 0.78
            textBoddy.lineBreakMode = NSLineBreakMode.byWordWrapping
            textBoddy.numberOfLines = 0
            textBoddy.text = "Aline Reis, Gustavo Oliveira, Higor Crisostomo, Marcelo Araujo e Pedro Hemmel built the Eyes on you app as a Free app. This SERVICE is provided by Aline Reis, Gustavo Oliveira, Higor Crisostomo, Marcelo Araujo e Pedro Hemmel at no cost and is intended for use as is. This page is used to inform visitors regarding my policies with the collection, use, and disclosure of Personal Information if anyone decided to use my Service. If you choose to use my Service, then you agree to the collection and use of information in relation to this policy. The Personal Information that I collect is used for providing and improving the Service. I will not use or share your information with anyone except as described in this Privacy Policy. The terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which are accessible at Eyes on you unless otherwise defined in this Privacy Policy. Information Collection and Use For a better experience, while using our Service, I may require you to provide us with certain personally identifiable information. The information that I request will be retained on your device and is not collected by me in any way. Log Data I want to inform you that whenever you use my Service, in a case of an error in the app I collect data and information (through third-party products) on your phone called Log Data. This Log Data may include information such as your device Internet Protocol (“IP”) address, device name, operating system version, the configuration of the app when utilizing my Service, the time and date of your use of the Service, and other statistics. Cookies Cookies are files with a small amount of data that are commonly used as anonymous unique identifiers. These are sent to your browser from the websites that you visit and are stored on your device's internal memory. This Service does not use these “cookies” explicitly. However, the app may use third-party code and libraries that use “cookies” to collect information and improve their services. You have the option to either accept or refuse these cookies and know when a cookie is being sent to your device. If you choose to refuse our cookies, you may not be able to use some portions of this Service. Service Providers I may employ third-party companies and individuals due to the following reasons: To facilitate our Service; To provide the Service on our behalf; To perform Service-related services; or To assist us in analyzing how our Service is used. I want to inform users of this Service that these third parties have access to their Personal Information. The reason is to perform the tasks assigned to them on our behalf. However, they are obligated not to disclose or use the information for any other purpose. Security I value your trust in providing us your Personal Information, thus we are striving to use commercially acceptable means of protecting it. But remember that no method of transmission over the internet, or method of electronic storage is 100% secure and reliable, and I cannot guarantee its absolute security. Links to Other Sites This Service may contain links to other sites. If you click on a third-party link, you will be directed to that site. Note that these external sites are not operated by me. Therefore, I strongly advise you to review the Privacy Policy of these websites. I have no control over and assume no responsibility for the content, privacy policies, or practices of any third-party sites or services. Children’s Privacy I do not knowingly collect personally identifiable information from children. I encourage all children to never submit any personally identifiable information through the Application and/or Services. I encourage parents and legal guardians to monitor their children's Internet usage and to help enforce this Policy by instructing their children never to provide personally identifiable information through the Application and/or Services without their permission. If you have reason to believe that a child has provided personally identifiable information to us through the Application and/or Services, please contact us. You must also be at least 16 years of age to consent to the processing of your personally identifiable information in your country (in some countries we may allow your parent or guardian to do so on your behalf). Changes to This Privacy Policy I may update our Privacy Policy from time to time. Thus, you are advised to review this page periodically for any changes. I will notify you of any changes by posting the new Privacy Policy on this page. This policy is effective as of 2022-11-25 Contact Us If you have any questions or suggestions about my Privacy Policy, do not hesitate to contact me at eyesonyouapp@gmail.com. This privacy policy page was created at privacypolicytemplate.net and modified/generated by App Privacy Policy Generator.".localizedLanguage()
            
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
            title.text = "Terms of use".localizedLanguage()
            
            let textBoddy = SKLabelNode(fontNamed: "")
            textBoddy.fontSize = 16
            textBoddy.position = CGPoint(x: frame.midX , y: frame.minY - frame.height * 2.3)
            textBoddy.preferredMaxLayoutWidth = frame.width * 0.78
            textBoddy.lineBreakMode = NSLineBreakMode.byWordWrapping
            textBoddy.numberOfLines = 0
            textBoddy.text = "By downloading or using the app, these terms will automatically apply to you – you should make sure therefore that you read them carefully before using the app. You’re not allowed to copy or modify the app, any part of the app, or our trademarks in any way. You’re not allowed to attempt to extract the source code of the app, and you also shouldn’t try to translate the app into other languages or make derivative versions. The app itself, and all the trademarks, copyright, database rights, and other intellectual property rights related to it, still belong to Aline Reis, Gustavo Oliveira, Higor Crisostomo, Marcelo Araujo e Pedro Hemmel. Aline Reis, Gustavo Oliveira, Higor Crisostomo, Marcelo Araujo e Pedro Hemmel is committed to ensuring that the app is as useful and efficient as possible. For that reason, we reserve the right to make changes to the app or to charge for its services, at any time and for any reason. We will never charge you for the app or its services without making it very clear to you exactly what you’re paying for. The Eyes on you app stores and processes personal data that you have provided to us, to provide my Service. It’s your responsibility to keep your phone and access to the app secure. We therefore recommend that you do not jailbreak or root your phone, which is the process of removing software restrictions and limitations imposed by the official operating system of your device. It could make your phone vulnerable to malware/viruses/malicious programs, compromise your phone’s security features and it could mean that the Eyes on you app won’t work properly or at all. You should be aware that there are certain things that Aline Reis, Gustavo Oliveira, Higor Crisostomo, Marcelo Araujo e Pedro Hemmel will not take responsibility for. Certain functions of the app will require the app to have an active internet connection. The connection can be Wi-Fi or provided by your mobile network provider, but Aline Reis, Gustavo Oliveira, Higor Crisostomo, Marcelo Araujo e Pedro Hemmel cannot take responsibility for the app not working at full functionality if you don’t have access to Wi-Fi, and you don’t have any of your data allowance left. If you’re using the app outside of an area with Wi-Fi, you should remember that the terms of the agreement with your mobile network provider will still apply. As a result, you may be charged by your mobile provider for the cost of data for the duration of the connection while accessing the app, or other third-party charges. In using the app, you’re accepting responsibility for any such charges, including roaming data charges if you use the app outside of your home territory (i.e. region or country) without turning off data roaming. If you are not the bill payer for the device on which you’re using the app, please be aware that we assume that you have received permission from the bill payer for using the app. Along the same lines, Aline Reis, Gustavo Oliveira, Higor Crisostomo, Marcelo Araujo e Pedro Hemmel cannot always take responsibility for the way you use the app i.e. You need to make sure that your device stays charged – if it runs out of battery and you can’t turn it on to avail the Service, Aline Reis, Gustavo Oliveira, Higor Crisostomo, Marcelo Araujo e Pedro Hemmel cannot accept responsibility. With respect to Aline Reis, Gustavo Oliveira, Higor Crisostomo, Marcelo Araujo e Pedro Hemmel’s responsibility for your use of the app, when you’re using the app, it’s important to bear in mind that although we endeavor to ensure that it is updated and correct at all times, we do rely on third parties to provide information to us so that we can make it available to you. Aline Reis, Gustavo Oliveira, Higor Crisostomo, Marcelo Araujo e Pedro Hemmel accepts no liability for any loss, direct or indirect, you experience as a result of relying wholly on this functionality of the app. At some point, we may wish to update the app. The app is currently available on iOS – the requirements for the system(and for any additional systems we decide to extend the availability of the app to) may change, and you’ll need to download the updates if you want to keep using the app. Aline Reis, Gustavo Oliveira, Higor Crisostomo, Marcelo Araujo e Pedro Hemmel does not promise that it will always update the app so that it is relevant to you and/or works with the iOS version that you have installed on your device. However, you promise to always accept updates to the application when offered to you, We may also wish to stop providing the app, and may terminate use of it at any time without giving notice of termination to you. Unless we tell you otherwise, upon any termination, (a) the rights and licenses granted to you in these terms will end; (b) you must stop using the app, and (if needed) delete it from your device. Changes to This Terms and Conditions I may update our Terms and Conditions from time to time. Thus, you are advised to review this page periodically for any changes. I will notify you of any changes by posting the new Terms and Conditions on this page. These terms and conditions are effective as of 2022-11-25 Contact Us If you have any questions or suggestions about my Terms and Conditions, do not hesitate to contact me at eyesonyouapp@gmail.com. This Terms and Conditions page was generated by App Privacy Policy Generator".localizedLanguage()
            
            moveableNode.addChild(title)
            moveableNode.addChild(textBoddy)
            
            
        }
    }
    

