//
//  PlayingCards.swift
//  Casino
//
//  Created by Jonathan Schmidt on 10/06/2014.
//  Copyright (c) 2014 Matelli. All rights reserved.
//

import Foundation

struct Shoe
{
    enum ShoeType
    {
        case CSM
        case Manual
    }
    
    class Card
    {
        enum Color: String
        {
            case None = ""
            case Red = "red"
            case Black = "black"
        }
        
        enum Value: Int
        {
            case None = 0
            case Ace
            case Two
            case Three
            case Four
            case Five
            case Six
            case Seven
            case Eight
            case Nine
            case Ten
            case Jack
            case Queen
            case King
            case Joker
        }
        
        enum Suit: Int
        {
            case None = 0
            case Heart
            case Diamond
            case Spade
            case Club
            
            static func colorFromSuit(suit:Suit) -> Shoe.Card.Color
            {
                switch suit
                {
                case Suit.Heart, Suit.Diamond:
                    return .Red
                case Suit.Spade, Suit.Club:
                    return .Black
                default:
                    return .None
                }
            }
        }
        
        let color:Color
        let value:Value
        let suit:Suit
        
        init() {
            self.color = .None
            self.value = .None
            self.suit = .None
        }
        
        init(color:Color, value:Value, suit:Suit)
        {
            self.color = color
            self.value = value
            self.suit = suit
        }
        
        class func deck52Cards() -> Card[]
        {
            var deck = Card[]()
            for suit in 1...4
            {
                var color = Suit.colorFromSuit(Suit.fromRaw(suit)!)
                
                for value in 1...13
                {
                    deck += Card(color: color, value: Value.fromRaw(value)!, suit:Suit.fromRaw(suit)!)
                }
            }
            return deck
        }
    }
    
    var shoe:Card[]
    var discard = Card[]()
    var shoeType:ShoeType
    
    init(shoeType:ShoeType)
    {
        self.shoeType = shoeType
        switch shoeType
        {
        case .CSM:
            self.shoe = Card[]()
        case .Manual:
            self.shoe = Card[]()
            for _ in 1...8
            {
                self.shoe += Card.deck52Cards()
            }
            Shoe.shuffleDeck(&self.shoe)
        }
    }
    
    static func shuffleDeck(inout deck:Card[])
    {
        for index in 0..deck.count
        {
            let destination = Int(arc4random_uniform(UInt32(deck.count - index))) + index
            let temp = deck[index]
            deck[index] = deck[destination]
            deck[destination] = temp
        }
    }
    
    mutating func drawCard() -> Card
    {
        if self.shoeType == .CSM
        {
            let suit = Card.Suit.fromRaw(Int(arc4random_uniform(3)+1))!
            let value = Card.Value.fromRaw(Int(arc4random_uniform(13)+1))!
            return Card(color: Card.Suit.colorFromSuit(suit), value: value, suit: suit)
        }
        else
        {
            if(self.shoe.count < 104)
            {
                self.shoe += self.discard
                self.discard = Card[]()
                Shoe.shuffleDeck(&self.shoe)
            }
            return self.shoe.removeLast()
        }
    }
}








