//
//  CardInfoView.swift
//  Banking
//
//  Created by Kevni Woodside on 4/14/22.
//

import SwiftUI

struct CardInfoView: View {
    var body: some View {
        VStack(alignment: .leading){
            ProgressView()
            
            HStack(alignment: .bottom, spacing: 0){
                Text("$")
                    .foregroundColor(ColorConstants.secondary)
                    .font(.system(size: 30, weight: Font.Weight.bold, design: Font.Design.rounded))
                    .padding(.trailing, 10)
                Text("5,600")
                    .bold()
                    .foregroundColor(.blue)
                    .font(.system(size: 35, weight: Font.Weight.bold, design: Font.Design.rounded))
                Text(".90")
                    .foregroundColor(ColorConstants.secondary)
                    .font(.system(size: 30, weight: Font.Weight.bold, design: Font.Design.rounded))
            }
            .padding(.top, 15)
            .padding(.bottom, 30)
            
            HStack(spacing:20){
                VStack(alignment: .leading, spacing: 20) {
                    Image(systemName: "creditcard.fill")
                    Image(systemName: "banknote.fill")
                    Image(systemName: "dot.radiowaves.right")
                }
                .foregroundColor(ColorConstants.secondary)
                .scaleEffect(1.4)
                
                VStack(alignment: .leading, spacing: 29){
                    Text("Bank Card")
                    Text("Bank Account")
                    Text("Pay")
                }
                .foregroundColor(.black)
                .opacity(0.8)
            }
            .padding(.top, 1)
        }
        .padding(.leading, 80)
        
    }
}

struct ProgressView: View {
    var body: some View {
        ZStack{
            Circle()
                .stroke(lineWidth: 4)
                .fill(ColorConstants.border)
                .frame(width: 50, height: 50)
            
            Circle()
                .trim(from: 0.0, to: 3/5)
                .stroke(style: StrokeStyle(lineWidth: 4, lineCap: .round))
                .fill(ColorConstants.graphLine)
                .frame(width: 50, height: 50)
                .rotationEffect(Angle.degrees(-90))
                
            
            Text("3/5")
                .font(.system(size: 14))
                .bold()
                .foregroundColor(.black)
                
        }
        .padding(.bottom, 20)
        .padding(.top, 20)
    }
}
struct CardDetailTopBarView: View {
    @Binding var card: Card
    
    var body: some View {
        HStack{
            Button(action: {
                withAnimation(Animation.linear(duration: 1.0)) {
                    card.selected = false
                }
                
            }, label: {
                Image(systemName: "multiply")
                    .padding(.all, 20)
                    .scaleEffect(1.3)
            })
            
            Text("CARD DETAILS")
                .kerning(2)
                .bold()
            
            Spacer()
            
            Button(action: {}, label: {
                Image(systemName: "slider.vertical.3")
                    .padding(.all, 20)
                    .scaleEffect(1.5)             })
            
        }
        .foregroundColor(.black)
        .padding(.top, 64)
        .padding(.bottom, 20)
        .padding(.leading, 20)
        .padding(.trailing, 20)
    }
}
