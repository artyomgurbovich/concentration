//
//  ViewController.swift
//  Concentration
//
//  Created by Artyom Gurbovich on 11/21/19.
//  Copyright © 2019 Artyom Gurbovich. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var emojiChoices = [String]()
    
    var emoji = [Int: String]()
    
    var game = Concentration()
    
    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for button in cardButtons {
            button.layer.borderWidth = 3
            button.layer.borderColor = #colorLiteral(red: 0.5, green: 0.2511111111, blue: 0.06078431375, alpha: 1)
            button.layer.cornerRadius = 8
        }
        game.numberOfPairsOfCards = (cardButtons.count + 1) / 2
        startOver()
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            if let flipStatus = game.chooseCard(at: cardNumber) {
                if flipStatus {
                    flipCount += 1
                }
            } else {
                startOver()
            }
            updateViewFromModel()
        } else {
            print("Error: chosen card wasn't in cardButtons.")
        }
    }
    
    @IBAction func startOverTapped(_ sender: UIButton) {
        startOver()
    }
    
    func startOver() {
        emojiChoices = ["🕷", "🦇", "🦟", "💀", "☠️", "👻", "🍬", "🍭", "😈", "🍎", "🙀", "🎃"]
        game.newGame()
        updateViewFromModel()
        flipCount = 0
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(self.emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 0.9524647887, green: 0.9524647887, blue: 0.9524647887, alpha: 1)
                button.layer.borderColor = #colorLiteral(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.2024372799, green: 0.1008217041, blue: 0.02461002228, alpha: 1) : #colorLiteral(red: 1, green: 0.4980392157, blue: 0.1215686275, alpha: 1)
                button.layer.borderColor = card.isMatched ? #colorLiteral(red: 0.09999449824, green: 0.04980118148, blue: 0.01215619391, alpha: 1) : #colorLiteral(red: 0.5, green: 0.2511111112, blue: 0.06078431375, alpha: 1)
            }
        }
    }
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int.random(in: 0..<emojiChoices.count)
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
}
