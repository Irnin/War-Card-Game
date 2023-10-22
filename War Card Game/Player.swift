//
//  Player.swift
//  War Card Game
//
//  Created by Łukasz Michalak on 21/10/2023.
//

import Foundation

class Player: ObservableObject {
    @Published var hand: [Card] = []
    
    var cardsOnHand: Int {
        return hand.count
    }
    
    func addCard(card: Card) {
        hand.append(card)
    }
    
    func getCard() -> Card? {
        
        if(hand.isEmpty) {
            return nil
        }
        
        let card = hand[0]
        hand.removeFirst()
        
        return card
    }
    
    func addCard(_ card: Card) {
        hand.append(card)
    }
}
