//
//  Concentration.swift
//  Concentration
//
//  Created by Artyom Gurbovich on 11/24/19.
//  Copyright © 2019 Artyom Gurbovich. All rights reserved.
//

import Foundation

class Concentration {
    var cards = [Card]()
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    var numberOfPairsOfCards = 0
    
    func chooseCard(at index: Int) -> Bool? {
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard {
                if matchIndex != index {
                    if cards[matchIndex].identifier == cards[index].identifier {
                        cards[matchIndex].isMatched = true
                        cards[index].isMatched = true
                        if isGameEnd() {
                            return nil
                        }
                    }
                    cards[index].isFaceUp = true
                    indexOfOneAndOnlyFaceUpCard = nil
                    return true
                } else {
                    return false
                }
            } else {
                for flipDomnIndex in cards.indices {
                    cards[flipDomnIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
                return true
            }
        }
        return false
    }
    
    func isGameEnd() -> Bool {
        for card in cards {
            if !card.isMatched {
                return false
            }
        }
        return true
    }
    
    func newGame() {
        cards = [Card]()
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }
}
