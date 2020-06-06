//
//  Concentration.swift
//  Concentration
//
//  Created by cycu on 2019/3/11.
//  Copyright © 2019 cycu. All rights reserved.
//

import Foundation

struct Concentration{
    
    var cards=Array<Card>()
    
    private var indexOfOneAndOnlyFaceUpCard: Int?{
        
        get{
//            let faceUpCardIndices = cards.indices.filter{ cards[$0].isFaceUp}
//            return faceUpCardIndices.count == 1 ? faceUpCardIndices.first : nil
            
        return cards.indices.filter{cards[$0].isFaceUp}.oneAndOnly
//            var foundIndex: Int?
//            for index in cards.indices{
//                if cards[index].isFaceUp{
//                    if foundIndex == nil {
//                        foundIndex = index
//                    }else{
//                        return nil
//                    }
//                }
//            }
//            return foundIndex
        }
        set{
            for index in cards.indices{
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    mutating func chooseCard(at index: Int){
        assert(cards.indices.contains(index),"Concentration.chooseCard(at:\(index)):choosen ondex not in the cards")
        
        if !cards[index].isMatched{
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex] == cards[index]{
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            }else{
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards:Int) {
        assert(numberOfPairsOfCards>0,"Concentration.init(\(numberOfPairsOfCards)):you must have at least one pair cards")
        for _ in 0..<numberOfPairsOfCards{
            let card = Card()
           cards += [card,card]
        }
    }
}

extension Collection{
    var oneAndOnly : Element?{
        return count == 1 ? first : nil
    }
}
