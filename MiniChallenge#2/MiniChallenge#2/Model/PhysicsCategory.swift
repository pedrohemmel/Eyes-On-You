//
//  PhysicsCategory.swift
//  MiniChallenge#2
//
//  Created by Pedro Henrique Dias Hemmel de Oliveira Souza on 17/11/22.
//

import Foundation

struct PhysicsCategory {
    static let character: UInt32 = 0x1 << 1
    static let obstacle: UInt32 = 0x1 << 2
    static let ground: UInt32 = 0x1 << 3
}
