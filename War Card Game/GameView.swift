//
//  GameView.swift
//  War Card Game
//
//  Created by Łukasz Michalak on 22/10/2023.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var game: Game
    
    var body: some View {
        ZStack {
            Image("background-wood-grain")
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                // CPU cards
                HStack {
                    VStack {
                        if(game.players["CPU"]!.cardsOnHand != 0) {
                            Image("red")
                                .resizable()
                                .scaledToFit()
                                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: nil)
                            
                            Text("\(game.players["CPU"]!.cardsOnHand) cards")
                        }
                        else {
                            Text("Looser")
                                .foregroundColor(.red)
                        }
                        
                    }
                    
                    Spacer()
                    ZStack {
                        if(game.cpuWonStep) {
                            Image(systemName: "crown.fill")
                                .font(.system(size: 100))
                                .foregroundColor(.orange)
                        }
                        
                        Text("CPU")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .padding()
                    }
                    Spacer()
                }
                .padding()
                
                Spacer()

                ScrollView(.horizontal) {
                    HStack{
                        ForEach(game.cardsStack, id: \.self) { card in
                            Image(card.getLabel())
                                .resizable()
                                .scaledToFit()
                                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: nil)
                        }
                    }
                }
                
                Spacer()
                
                // Player cards
                HStack {
                    Spacer()
                    ZStack {
                        if(game.playerWonStep) {
                            Image(systemName: "crown.fill")
                                .font(.system(size: 100))
                                .foregroundColor(.orange)
                        }
                        
                        Text("Player")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .padding()
                    }
                    Spacer()
                    
                    VStack {
                        
                        if(game.players["Player"]!.cardsOnHand != 0) {
                            Button {
                                usersMove()
                            } label: {
                                Image("red")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: nil)
                            }
                            
                            Text("\(game.players["Player"]!.cardsOnHand) cards")
                        }
                        else {
                            Text("Looser")
                                .foregroundColor(.red)
                        }
                    }
                }
                .padding()
            }
            
            if(game.players["CPU"]!.cardsOnHand == 0) {
                Text("You won")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.orange)
            }
            else if(game.players["Player"]!.cardsOnHand == 0) {
                Text("You lose")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.red)
            }
            
            
        }
    }
    
    func usersMove() {
        game.step()
    }
}

#Preview {    
    GameView(game: Game(fastGame: true))
}
