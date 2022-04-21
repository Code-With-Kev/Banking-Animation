//
//  MenuHeaderView.swift
//  Banking
//
//  Created by Kevni Woodside on 4/13/22.
//

import SwiftUI

struct MenuHeaderView: View {
    let title: String
    let imageName: String
    
    var body: some View {
        ZStack{
            ColorConstants.secondary
            
        HStack {
            Text(title)
                .font(.system(size: 24))
                .bold()
            
            Spacer()
            Button(action: {}, label: {
                Image(systemName: imageName)
                    .padding(.vertical, 15)
                    .padding(.horizontal, 20)
                
            })
        }
        .foregroundColor(.white)
        .padding(.leading, 20)
        .padding(.trailing, 20)
        }
        .frame(height: 3)
        .padding(.bottom, 25)
        .padding(.top, 35)
    }
}

struct MenuHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(selectedCard: cards[0])
            .previewDevice("iPhone 11")
    }
}
