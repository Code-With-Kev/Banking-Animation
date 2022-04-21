//
//  TransactionListView.swift
//  Banking
//
//  Created by Kevni Woodside on 4/13/22.
//

import SwiftUI

struct TransactionListView: View {
    @Binding var currentIndex: Int
    @ObservedObject var cardManager: CardManager
    
    
    var body: some View {
        ScrollView{
            LazyVStack{
                ForEach(getListHeaders(), id: \.self) { date in
                    ListHeader(title: cardManager.getModifiedDate(date: date))
                    ForEach(getTransactions(date: date), id: \.self) {transaction in
                        
                        TransactionListRow(transaction: transaction, isLast: cardManager.lastTransactionID == transaction.id)
                    }
                }
            }
        }
    }
    
    func getTransactions(date: String) -> [TransactionItem] {
        return cardManager.getTransaction(for: date, number: cards[currentIndex].number)
    }
    
    //Get dates for heading
    func getListHeaders() -> [String] {
        return cardManager.getUniqueDates(for: cards[currentIndex].number)
    }
}

struct ListHeader: View {
    let title: String
    var body: some View {
        HStack {
            Text(title)
                .font(.caption)
                .foregroundColor(ColorConstants.secondary)
                .padding(.leading, 20)
            Spacer()
        }
    }
}


struct TransactionListRow: View {
    let transaction: TransactionItem
    let isLast: Bool
    var body: some View {
        VStack{
            HStack(spacing: 0) {
                ZStack {
                    //MARK: - SYMBOL CIRCLE
                    Circle()
                        .fill(ColorConstants.secondary)
                        .frame(width: 50, height: 50)
                    Image(systemName: "applelogo")
                        .frame(width: 40)
                        .foregroundColor(.white)
                }
                //MARK: - SERVICE AND TYPE
                VStack(alignment: .leading) {
                    Text(transaction.service)
                        .foregroundColor(.black)
                    Text(transaction.type)
                        .font(.caption)
                        .foregroundColor(ColorConstants.secondary)
                }
                .padding(.leading, 10)
                
                Spacer()
                //MARK: - PRICE AND TIME
                VStack(alignment: .trailing) {
                    Text("- \(String(format: "%.2f", transaction.amount)) USD")
                        .foregroundColor(.black)
                    Text(transaction.time)
                        .font(.caption)
                        .foregroundColor(ColorConstants.secondary)
                }
            }
            .padding(.leading, 20)
            .padding(.trailing, 20)
            
            Divider()
                .background(ColorConstants.secondary)
                .padding(.leading, 80)
                .padding(.bottom, 12)
                .opacity(isLast ? 0.0 : 1.0)
                
        }
    }
}

