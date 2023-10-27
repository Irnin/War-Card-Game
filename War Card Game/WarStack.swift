//
//  WarStack.swift
//  War Card Game
//
//  Created by Łukasz Michalak on 26/10/2023.
//

import SwiftUI

struct WarStack: View {
    
    @State var cardsStack: [Card]
    
    var body: some View {
        Text("Hehe")
        
    }
}

#Preview {
    
    var cards: [Card] = []
    
    // First CPU card
    var card = Card(value: .Ace, suit: .Spades, isVisiable: true)
    cards.append(card)
    
    // First Player card
    card = Card(value: .Ace, suit: .Diamonds, isVisiable: true)
    cards.append(card)
    
    
    
    return WarStack(cardsStack: cards)
    
}
