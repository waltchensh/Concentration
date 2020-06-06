//
//  Card.swift
//  Concentration
//
//  Created by cycu on 2019/3/11.
//  Copyright © 2019 cycu. All rights reserved.
//

import Foundation


struct Card:Hashable{
    
    public var hashValue: Int{return identifier}
    
    public static func == (lhs: Card, rhs: Card) -> Bool{
        return lhs.identifier == rhs.identifier
    }

    var isFaceUp = false
    
    var isMatched = false
    
    private var identifier:Int
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier()-> Int {
       identifierFactory+=1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
