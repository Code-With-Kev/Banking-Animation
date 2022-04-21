//
//  CardView.swift
//  Banking
//
//  Created by Kevni Woodside on 4/13/22.
//

import SwiftUI

struct CardView: View {
    let card: Card
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 40)
                .fill(ColorConstants.cardBackground)
            
            VStack{
                HStack{
                    VStack(alignment: .leading){
                        Text(card.company.uppercased())
                            .font(.system(size: 14))
                            .bold()
                            .kerning(2)
                        
                        Text(card.type.rawValue.uppercased())
                            .font(.system(size: 14))
                            .bold()
                            .kerning(2)

                    }
                    Spacer()
                    
                    Text(card.company.uppercased())
                        .font(.system(size: 24, weight: Font.Weight.heavy))
                        .italic()
                        .padding(.trailing, 40)
                    
                }
                .padding(.top, 40)
                .padding(.leading, 40)

                Spacer()
                
                HStack {
                    ForEach(0..<3) { i in
                        Text("****")
                            .kerning(3.0)
                        Spacer()
                    }
                    
                    Text(card.getLastFourDigits())
                        .kerning(2.0)
                    
                }
                .padding(.all, 30)
            }
        }
        .foregroundColor(.white)
        .padding(.trailing, 20)
        .padding(.leading, 20)

    }
}
