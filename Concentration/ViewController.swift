//
//  ViewController.swift
//  Concentration
//
//  Created by Anastasia Krylova on 19.02.2022.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    
    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    var emojiChoices = ["🦉", "🦊", "🐝", "🐞", "🐙", "🦐", "🎸", "🔆", "💚"]
    
    var emoji = [Int:String]()
    
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBAction func newGame(_ sender: UIButton) {
        game.resetGame()
        updateViewFromModel()
        flipCount = 0
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("choosen card was not in cardButtons")
        }
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji (for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5843137255, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5843137255, blue: 0, alpha: 1)
            }
        }
    }
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
}

