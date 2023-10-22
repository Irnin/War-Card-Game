//
//  ContentView.swift
//  War Card Game
//
//  Created by Łukasz Michalak on 21/10/2023.
//

import SwiftUI

struct ContentView: View {
    @State  var cards: [Card] = []
    
    var body: some View {
        
        List{
            VStack(alignment: .center) {
                Button {
                    generateCards()
                } label: {
                    Text("Generate Cards")
                }
                
                ForEach(cards, id: \.self) { card in
                    Image(card.getLabel())
                }                
            }
            .padding()
        }
        
    }
    
    func generateCards() {
        cards.removeAll()
        let suits: [Card.Suit] = [.Hearts, .Diamonds, .Clubs, .Spades]
        
        for value in Card.Value.allCases {
            cards.append(Card(value: value, suit: suits.randomElement()!))
        }
    }
}

#Preview {
    ContentView()
}
