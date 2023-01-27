//
//  DataLoaderOfCharacterToSell.swift
//  MiniChallenge#2
//
//  Created by Pedro henrique Dias hemmel de oliveira souza on 27/12/22.
//

import Foundation


class DataLoaderOfCharacterToSell {
    
    var charactersToSell = [CharacterToSell]()
    
    init() {
        self.loadData()
        self.sortData()
    }
    
    public func loadData() {
        if let fileLocation = Bundle.main.path(forResource: "CharactersToSell", ofType: "json") {
            do {
                
                guard let contentFromJSON = try String(contentsOfFile: fileLocation).data(using: .utf8) else { return }
                let jsonDecoder = JSONDecoder()
                let dataFromJSON = try jsonDecoder.decode([CharacterToSell].self, from: contentFromJSON)
                
                self.charactersToSell = dataFromJSON
            } catch {
                print("Não consegui localizar a arquivo de json do CharactersToSell")
            }
        } else {
            print("nothing")
        }
    }
    
    public func sortData() {
        self.charactersToSell = self.charactersToSell.sorted(by: { $0.price < $1.price })
    }
}
