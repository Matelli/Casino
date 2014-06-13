//
//  Blackjack.swift
//  Casino
//
//  Created by Jonathan Schmidt on 10/06/2014.
//  Copyright (c) 2014 Matelli. All rights reserved.
//

import Foundation

class Blackjack
{
    class Game
    {
        struct Player
        {
            var hand:Hand = Hand()
            
            class Hand
            {
                var cards:Shoe.Card[] = []
                var value:Int
                {
                var score = 0
                    var aces = 0
                    for card in self.cards
                    {
                        switch card.value.toRaw()
                            {
                        case 0:
                            break
                            
                        case 1:
                            aces += 1
                            
                        case 2...10:
                            score += card.value.toRaw()
                            
                        default:
                            score += 10
                        }
                    }
                    while aces > 0
                    {
                        if score + (11*aces) > 21
                        {
                            score += 1
                            aces -= 1
                        }
                        else
                        {
                            score += aces * 11
                            aces = 0
                        }
                        
                    }
                    return score
                }
                
                init() {}
                
                init(card:Shoe.Card)
                {
                    self.cards = [card]
                }
                
                init(cards:Shoe.Card[])
                {
                    self.cards = cards
                }
            }
        }
    }
}