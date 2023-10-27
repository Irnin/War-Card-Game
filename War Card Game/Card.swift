//
//  Card.swift
//  War Card Game
//
//  Created by Łukasz Michalak on 21/10/2023.
//

import Foundation
import SwiftUI

class Card: Hashable, Equatable {
    public enum Suit: String, CaseIterable {
        case Hearts = "hearts"
        case Diamonds = "diamonds"
        case Clubs = "clubs"
        case Spades = "spades"
    }

    public enum Value: String, CaseIterable {
        case Two = "2"
        case Three = "3"
        case Four = "4"
        case Five = "5"
        case Six = "6"
        case Seven = "7"
        case Eight = "8"
        case Nine = "9"
        case Ten = "10"
        case Jack = "jack"
        case Queen = "queen"
        case King = "king"
        case Ace = "ace"
    }
    
    public static let SuitArray: [Suit] = [.Hearts, .Diamonds, .Clubs, .Spades]
    public static let ValueArray: [Value] = [.Two, .Three, .Four, .Five, .Six, .Seven, .Eight, .Nine, .Ten, .Jack, .Queen, .King, .Ace]
    
    var value: Value
    var suit: Suit
    var isVisable: Bool
    var offsetX: CGFloat = 0
    var offsetY: CGFloat = 0
    var rotatnion: Double = 0.0

    internal init(value: Value, suit: Suit, isVisiable: Bool = true) {
        self.value = value
        self.suit = suit
        self.isVisable = isVisiable
    }
    
    func getLabel() -> String {
        
        return isVisable ? suit.rawValue + "_" + value.rawValue : "red"
    }
    
    func getValue() -> Int {
        var v = 0
        
        switch self.value {
            
        case .Two:
            return 2
        case .Three:
            return 3
        case .Four:
            return 4
        case .Five:
            return 5
        case .Six:
            return 6
        case .Seven:
            return 7
        case .Eight:
            return 8
        case .Nine:
            return 9
        case .Ten:
            return 10
        case .Jack:
            return 11
        case .Queen:
            return 12
        case .King:
            return 13
        case .Ace:
            return 14
        }
    }
    
    // Umożliwia na porównywanie, czy karty są takie same
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.value == rhs.value && lhs.suit == rhs.suit
    }
    
    // Hashowanie
    func hash(into hasher: inout Hasher) {
        hasher.combine(value)
        hasher.combine(suit)
    }
    
    func throwCard() {
        // Przesunięcie X
        var move = Int.random(in: 10...20)
        var modify = Int.random(in: 2...3) % 2 == 0 ? 1 : -1
        offsetX = CGFloat(modify * move)
        
        // Przesunięcie Y
        move = Int.random(in: 10...20)
        modify = Int.random(in: 2...3) % 2 == 0 ? 1 : -1
        offsetY = CGFloat(modify * move)
        
        rotatnion = Double.random(in: -25...25)
    }
}
