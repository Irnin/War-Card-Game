//
//  Game.swift
//  War Card Game
//
//  Created by Łukasz Michalak on 21/10/2023.
//

import Foundation

class Game: ObservableObject {
    @Published var players: [String: Player] = [:]
    
    @Published var playerCard: Card? = nil
    @Published  var cpuCard: Card? = nil
    
    var isCardVisable: Bool = true
    @Published var cpuWonStep: Bool = false
    @Published var playerWonStep: Bool = false
    @Published public var endGame: Bool = false
    @Published var counter = 0
    
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
                
                let suit = Card.SuitArray.randomElement()!
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
        
        // Rozdawanie kart graczom 
        cards.shuffle()
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
    
    func getCardsOnTableCPU() -> [Card] {
        return players["CPU"]!.getCardsOnTable()
    }
    
    func getCardsOnTablePlayer() -> [Card] {
        return players["Player"]!.getCardsOnTable()
    }
    
    // Ruch gracza
    func step() {
        if (endGame) {
            return
        }
        
        if(cpuWonStep || playerWonStep) {
            // Komputer wygrał, przyznanie mu kart
            if(cpuWonStep) {
                let wonCards = players["Player"]?.lostTable()
                players["CPU"]?.winTable(wonCards: wonCards!)
                cpuWonStep = false
            }
            
            // Gracz wygrał, przypisanie mu kart
            else if (playerWonStep) {
                let wonCards = players["CPU"]?.lostTable()
                players["Player"]?.winTable(wonCards: wonCards!)
                playerWonStep = false
            }
        }
        else {
            // Pobieranie karty gracza
            guard let playerCard = players["Player"]?.getCard(isVisable: isCardVisable) else {
                return
            }
            
            // Pobieranie karty komputera
            guard let cpuCard = players["CPU"]?.getCard(isVisable: isCardVisable) else {
                return
            }
            
            // Jeżeli karty są ukryte to ignorujemy ponieważ trzeba dołożyć
            if(isCardVisable) {
                if(playerCard.getValue() > cpuCard.getValue()) {
                    playerWonStep = true
                    isCardVisable = true
                }
                else if (playerCard.getValue() < cpuCard.getValue()) {
                    cpuWonStep = true
                    isCardVisable = true
                }
                else {
                    isCardVisable = false
                }
            }
            else {
                isCardVisable = true
            }
            
        }
        
        counter += 1
    }
}
