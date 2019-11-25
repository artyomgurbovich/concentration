//
//  Card.swift
//  Concentration
//
//  Created by Artyom Gurbovich on 11/24/19.
//  Copyright © 2019 Artyom Gurbovich. All rights reserved.
//

import Foundation

struct Card {
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    static var identifierFactory = 0
    
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
