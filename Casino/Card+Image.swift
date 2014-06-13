//
//  Card+Image.swift
//  Casino
//
//  Created by Jonathan Schmidt on 11/06/2014.
//  Copyright (c) 2014 Matelli. All rights reserved.
//

import Foundation

extension Shoe.Card {
    func frontImage() -> UIImage {
        var valueString:String
        var suitString:String
        
        switch self.value {
        case .None:
            return UIImage()
        case .Joker:
            return UIImage(named: "\(self.color.toRaw())_joker")
        case .Ace:
            valueString = "ace"
        case .Two, .Three, .Four, .Five, .Six, .Seven, .Eight, .Nine, .Ten:
            valueString = String(self.value.toRaw())
        case .Jack:
            valueString = "jack"
        case .Queen:
            valueString = "queen"
        case .King:
            valueString = "king"
        }
        
        switch self.suit {
        case .None:
            return UIImage()
        case .Heart:
            suitString = "hearts"
        case .Diamond:
            suitString = "diamonds"
        case .Spade:
            suitString = "spades"
        case .Club:
            suitString = "clubs"
        }
        
        return UIImage(named: "\(valueString)_of_\(suitString)")
    }
    
    func backImage() -> UIImage {
        return UIImage(named: "backCover")
    }
}