//
//  ViewController.swift
//  Concentration
//
//  Created by cycu on 2019/3/4.
//  Copyright © 2019 cycu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
  private lazy  var game = Concentration(numberOfPairsOfCards: (cardButtons.count+1)/2)
    
    private var emojiChoices = "🥳👻🤪👀💖💝"
    
    var flipCount = 0 {
        didSet{
           updateFlipCountLabel()
        }
    }
    
    private func updateFlipCountLabel(){
        let attributes:[NSAttributedString.Key:Any] = [
        .strokeWidth : 5.0,
        .strokeColor: UIColor.orange,
        ]
        let attributedString = NSAttributedString(string: "Flips: \(flipCount)",attributes: attributes)
        flipCountLabel.attributedText = attributedString
    }
    
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender){
            //flipCard(withEmoji: emojiChoices[cardNumber], on: sender)
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }else{
            print("chosen card is not in cardButtons")
        }
    }
    
    func updateViewFromModel(){
        for index in cardButtons.indices{
            let button = cardButtons[index]
            
            let card = game.cards[index]
            
            if card.isFaceUp{
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }else{
                button.setTitle("", for: .normal)
                button.backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0):#colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
            }
        }
    }
    
    private var emoji = [Card:String]()
    
    func emoji(for card: Card)-> String{
        if  emoji[card] == nil,emojiChoices.count > 0{
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: Int.random(in: 0..<emojiChoices.count))
            emoji[card] = String(emojiChoices.remove(at: randomStringIndex))
        }
        return emoji[card] ?? "?"
    }
}
