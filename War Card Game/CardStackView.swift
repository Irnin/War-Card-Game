//
//  CardStackView.swift
//  War Card Game
//
//  Created by Łukasz Michalak on 27/10/2023.
//

import SwiftUI

struct CardStackView: View {
    @State var cards: [Card]
    
    var body: some View {
        
        ZStack {
            Text("Dupa tam \(cards.count)")
            ForEach(cards, id: \.self) { card in
                Image(card.getLabel())
                    .offset(x: card.offsetX, y: card.offsetY)
                    .rotationEffect(.degrees(card.rotatnion))
                    .font(.system(size: 100))
            }
        }
    }
}

//#Preview {
//    var cards: [Card] = []
//    
//    var card = Card(value: .Ace, suit: .Spades, isVisiable: true)
//    cards.append(card)
//    
//    card = Card(value: .Ace, suit: .Diamonds, isVisiable: false)
//    cards.append(card)
//    
//    card = Card(value: .King, suit: .Diamonds, isVisiable: true)
//    cards.append(card)
//    
//    for card in cards {
//        card.throwCard()
//    }
//    
//    
//    return CardStackView(cards: cards)
//}
