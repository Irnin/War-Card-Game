//
//  Game.swift
//  War Card Game
//
//  Created by Łukasz Michalak on 21/10/2023.
//

import Foundation

class Game: ObservableObject {
    
    var players: [String: Player] = [:]
    @Published var cardsStack: [Card] = []
    
    @Published var playerCard: Card? = nil
    @Published  var cpuCard: Card? = nil
    
    var additionalCard: Bool = false
    @Published var cpuWonStep: Bool = false
    @Published var playerWonStep: Bool = false
    @Published public var endGame: Bool = false
    
    // Game config
    var fastGame = true
    
    init(fastGame: Bool) {
        self.players["Player"] = Player()
        self.players["CPU"] = Player()
        self.fastGame = fastGame
        
        distributeCards()
    }

    func distributeCards() {
        var cards: [Card] = []
        var i = 0
        
        if(fastGame) {
            for value in Card.Value.allCases {
                
                var suit = Card.SuitArray.randomElement()!
                cards.append(Card(value: value, suit: suit))
            }
        }
        else {
            for value in Card.ValueArray {
                for suit in Card.SuitArray {
                    cards.append(Card(value: value, suit: suit))
                }
            }
        }
        
        cards.shuffle()
        
        print("Distributing cards:")
        
        for card in cards {
            if(i == 0) {
                players["Player"]!.addCard(card: card)
            }
            else if(i == 1) {
                players["CPU"]!.addCard(card: card)
            }
            
            i = (i + 1) % 2
        }
    }
    
    func step() {
        if (endGame) {
            return
        }
        
        if(cpuWonStep || playerWonStep) {
            if(cpuWonStep) {
                for card in cardsStack {
                    players["CPU"]?.addCard(card)
                }
                cpuWonStep = false
            }
            else if (playerWonStep) {
                for card in cardsStack {
                    players["Player"]?.addCard(card)
                }
                playerWonStep = false
            }
            cardsStack.removeAll()
        }
        else {
            // Pobieranie karty gracza
            guard let playerCard = players["Player"]?.getCard() else {
                return
            }
            
            if(additionalCard) { playerCard.isVisable = false}
            cardsStack.append(playerCard)
            
            // Pobieranie karty komputera
            guard let cpuCard = players["CPU"]?.getCard() else {
                return
            }
            
            if(additionalCard) {cpuCard.isVisable = false}
            cardsStack.append(cpuCard)
            
            if(additionalCard) {
                additionalCard = false
            }
            else {
                if(playerCard.getValue() > cpuCard.getValue()) {playerWonStep = true}
                else if (playerCard.getValue() < cpuCard.getValue()) {cpuWonStep = true}
                else {additionalCard = true}
            }
        }
    }
}
