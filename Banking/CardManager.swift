//
//  CardManager.swift
//  Banking
//
//  Created by Kevni Woodside on 4/13/22.
//

import SwiftUI

class CardManager: ObservableObject {
    
    let currentDateString = "19 Sep 2020"
    
    func getUniqueDates(for cardNumber: String) -> [String] {
        var dates: [String] = []
        
        var lastDate = ""
        
        for transaction in transactions {
            if transaction.card == cardNumber && transaction.date != lastDate {
                dates.append(transaction.date)
                lastDate = transaction.date
            }
        }
        return dates
    }
    
    //CHANGE LABEL FOR TODAY AND YESTERDAY

    func getModifiedDate(date: String) -> String {
        var modifiedDate = date
        
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "dd MMM yyyy"
        
        if let currentDate = dateFormater.date(from: currentDateString) {
            if let givenDate = dateFormater.date(from: date) {
                let difference = Calendar.current.dateComponents([.day], from: currentDate, to: givenDate)
                if abs(difference.day!) == 0 {
                    modifiedDate = "Today"
                } else if abs(difference.day!) == 1 {
                    modifiedDate = "Yesterday"
                }
            }
        }
        return modifiedDate
    }
    
    var lastTransactionID = UUID()
    
    func getTransaction(for date: String, number: String) -> [TransactionItem] {
        var transaction: [TransactionItem] = []
        //if a transaction matches a date and a card's number, display the transaction
        for transac in transactions {
            if transac.date == date && transac.card == number{
                transaction.append(transac)
            }
        }
        
        if transaction.count > 0 {
            lastTransactionID = transaction.last!.id
        }
        return transaction
    }
    
    
    //Loop through expences and return the largest one for each month
    func getMaxExpences() -> Float {
        return expences.map { $0.amount }.max()!
    }
    
    
    
    @Published var expencesValue = expences
    var lastSelectedExpence = -1
    
    func selectExpence(expence: Expence) {
        if let foundIndex = expencesValue.firstIndex(where: {$0.id == expence.id}) {
            expencesValue[foundIndex].selected.toggle()
            
            if foundIndex == lastSelectedExpence {
                lastSelectedExpence = -1
            } else {
                if lastSelectedExpence != -1 {
                    expencesValue[lastSelectedExpence].selected.toggle()
                }
                lastSelectedExpence = foundIndex
            }
        }
    }
    
    // Loop through the array of expenses and divide each one by the largest amount.
    func getExpencesDataBasedOnHeight(maxHeight: CGFloat) -> [CGFloat] {
        var heights: [CGFloat] = []
        let max = getMaxExpences()
        
        for expence in expencesValue {
            let fraction: CGFloat = CGFloat(expence.amount / max)
            let barHeight = maxHeight - CGFloat(fraction * maxHeight)
            
            heights.append(barHeight)
        }
        return heights
    }
    

    
//@Published var expences = expences
    
}
