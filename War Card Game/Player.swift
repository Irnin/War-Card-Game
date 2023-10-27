//
//  Player.swift
//  War Card Game
//
//  Created by Łukasz Michalak on 21/10/2023.
//

import Foundation

class Player: ObservableObject {
    @Published var hand: [Card] = []
    @Published var cardsOnTable: [Card] = []
    
    var cardsOnHand: Int {
        return hand.count
    }
    
    func addCard(card: Card) {
        hand.append(card)
    }
    
    // Pobieranie karty z stoosu i rzucenie jej do gry
    func getCard(isVisable: Bool) -> Card? {
        
        if(hand.isEmpty) {
            return nil
        }
        
        let card = hand[0]
        card.isVisable = isVisable
        hand.removeFirst()
        cardsOnTable.append(card)
        card.throwCard()
    
        return card
    }
    
    func addCard(_ card: Card) {
        hand.append(card)
    }
    
    func lostTable() -> [Card] {
        let lostCards = cardsOnTable
        cardsOnTable.removeAll()
        return lostCards
    }
    
    func winTable(wonCards: [Card]) {
        hand = hand + cardsOnTable + wonCards
        cardsOnTable.removeAll()
    }
    
    func getCardsOnTable() -> [Card] {
        return cardsOnTable
    }
}
