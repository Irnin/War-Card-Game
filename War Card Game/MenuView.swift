import SwiftUI

struct MenuView: View {
    @State private var isNavigationActive = false
    @State private var fastGame = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("background-wood-grain")
                    .resizable()
                    .ignoresSafeArea()
                
                VStack {
                    Image("logo")
                    
                    Spacer()
                    
                    
                    Toggle("Fast game", isOn:$fastGame)
                    
                    Button(action: {
                        isNavigationActive = true
                    }) {
                        Text("Start Game")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .sheet(isPresented: $isNavigationActive) {
                        GameView(game: Game(fastGame: fastGame))
                    }
                    
                    
                    Spacer()
                }
                .padding(.horizontal)
            }
        }
    }
}

#Preview {
    MenuView()
}
