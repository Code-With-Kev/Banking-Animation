//
//  ContentView.swift
//  Banking
//
//  Created by Kevni Woodside on 4/11/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var cardManager = CardManager()
    @State private var currentPage = 0
    @State var selectedCard: Card
    
    var body: some View {
        ZStack {
            Rectangle().fill(ColorConstants.primary)
            
            VStack{
                TopBarView()
                
                PagerView(pageCount: cards.count, currentIndex: $currentPage) {
                    ForEach(cards) { card in
                        CardView(card: card)
                            //ON TAP SHOW DETAILED VIEW
                            .onTapGesture {
                                withAnimation {
                                    selectedCard = card
                                    selectedCard.selected = true
                                }
                            }
                    }
                }
                .frame(height: 240)
                
                MenuHeaderView(title: "Transactions", imageName: "arrow.up.arrow.down")
                
                //Transactions shown change depending on credit card used
                TransactionListView(currentIndex: $currentPage, cardManager: cardManager)
                
                
                Spacer()
            }
            
            //MARK: - SELECTED CARD
            // When editing this screen use: if (!selectedCard.selected)
            //Remember to remove "!" after
            if (selectedCard.selected) {
                CardDetailView(card: $selectedCard, cardManager: cardManager)
            }
        } // Z STACK
        .edgesIgnoringSafeArea(.all)
    }
}

//MARK: - DETAILED VIEW
struct CardDetailView: View {
    @Binding var card: Card
    @ObservedObject var cardManager : CardManager
    @State var startAnimation = false
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(ColorConstants.primary)
                
            VStack {
                CardDetailTopBarView(card: $card)
                
                ZStack{
                    GeometryReader { geometry in
                        CardView(card: card)
                            .rotationEffect(startAnimation ? Angle.degrees(90) : Angle.degrees(0))
                            .offset(x: startAnimation ? -geometry.size.width/2 : 0)
                    }
                        .frame(height: 210)
                        //Might be a problem
                        .padding(.top, 20)
                        .padding(.bottom, 20)
                    
                    CardInfoView()
                        .opacity(startAnimation ? 1.0 : 0.0)
                        .animation(Animation.easeIn(duration: 0.5).delay(0.5), value: startAnimation)
                }
                .padding(.top, 20)
                .padding(.bottom, 20)
                
                ExpenseView(cardManager: cardManager)
                    .padding(.top, 20)
                    .padding(.bottom, 40)
                    .opacity(startAnimation ? 1.0 : 0.0)
                    .animation(Animation.easeIn(duration: 0.5).delay(1.5), value: startAnimation)
                
                Spacer()
                
            }
        }
        .onAppear {
            withAnimation {
                startAnimation = true
            }
        }
    }
}


//MARK: - NAVBAR
struct TopBarView: View {
    var body: some View{
        
        ZStack {
            HStack{
                Button(action: {}, label: {
                    Image(systemName: "line.horizontal.3")
                        .padding(.all, 20)
                })
                
                Text("HOME")
                    .kerning(2)
                    .bold()
                
                Spacer()
                
                Button(action: {}, label: {
                    Image(systemName: "magnifyingglass")
                        .padding(.all, 20)
                })
            }
            .foregroundColor(.black)
            .padding(.top, 64)
            .padding(.bottom, 20)
            .padding(.leading, 20)
        .padding(.trailing, 20)
        }

        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(selectedCard: cards[0])
            .previewDevice("iPhone 11")
    }
}


