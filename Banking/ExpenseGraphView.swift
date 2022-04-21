//
//  ExpenseGraphView.swift
//  Banking
//
//  Created by Kevni Woodside on 4/17/22.
//

import SwiftUI

struct ExpenseView: View {
    @ObservedObject var cardManager : CardManager
    var body: some View{
        VStack{
            MenuHeaderView(title: "Expenses", imageName: "ellipsis")
                .padding(.bottom, 20)
            ExpenseGraphView(cardManager: cardManager)
        }
    }
}

struct ExpenseGraphView: View {
    @ObservedObject var cardManager : CardManager
    @State var startAnimation = false
    var body: some View {
        VStack{
            GeometryReader { geometry in
                ZStack {
                    GraphBackgroundView()
                    ExpenseBarGraph(cardManager: cardManager, height: geometry.size.height)
                    ExpenseLineGraph(data: cardManager.getExpencesDataBasedOnHeight(
                        maxHeight: geometry.size.height))
                        .trim(to: startAnimation ? 1 : 0)
                        .stroke(lineWidth: 2.0)
                        .foregroundColor(ColorConstants.graphLine)
                        .animation(Animation.easeIn(duration: 2.0).delay(2.0), value: startAnimation)
                }
                .onAppear {
                    withAnimation {
                        startAnimation = true
                    }
                }
            }
            .padding(.leading,20)
            .padding(.trailing, 20)
                        
            HStack{
                ForEach(expences) { expense in
                    Text(expense.month)
                        .font(.caption)
                        .frame(width: 45)
                }
            }
            .foregroundColor(.black)
        }
    }
}

struct ExpenseLineGraph : Shape {
    
    let data: [CGFloat]
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        var x: CGFloat = 22.5
        var y: CGFloat = data[0]
        path.move(to: CGPoint(x: x, y: y))
        var previousPoint = CGPoint(x: x, y: y)
        x += 55
        
        for i in 1..<data.count {
            y = data[i]
            let currentPoint = CGPoint(x: x, y: y)
            let controlPoint1 = CGPoint(x: previousPoint.x + 25, y: previousPoint.y)
            let controlPoint2 = CGPoint(x: currentPoint.x - 25, y: currentPoint.y)
            
            path.addCurve(to: currentPoint, control1: controlPoint1, control2: controlPoint2)
            
            previousPoint = CGPoint(x: x, y: y)
            x += 55
        }
        return path
    }
}

struct ExpenseBarGraph: View {
    @ObservedObject var cardManager: CardManager
    let height: CGFloat
    var body: some View {
        HStack(alignment: .bottom) {
            ForEach (cardManager.expencesValue) { expence in
                
                VStack{
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(ColorConstants.secondary)
                            .frame(width: 60, height: 30)
                        Text("$ \(String(format: "%.2f", expence.amount))")
                            .font(.system(size: 9))
                            .foregroundColor(.white)
                    }
                    .offset(y: -25.0)
                    .zIndex(2.0)
                    .opacity(expence.selected ? 1.0 : 0.0)
                    
                    ZStack(alignment: .bottom) {
                        Rectangle()
                        //If you tap on an expense bar, it changes color to show it's selected
                            .fill(expence.selected ? ColorConstants.barHighlightedBackground : ColorConstants.barBackground)
                            .frame(width: 45, height: getHeightOfBar(maxHeight: height - 30, amount: expence.amount))
                            .onTapGesture {
                                withAnimation {
                                    cardManager.selectExpence(expence: expence)
                                }
                        }
                        
                        Line()
                            .stroke(ColorConstants.graphLine, lineWidth: 2.0)
                            .frame(height: 2)
                            .opacity(expence.selected ? 1.0 : 0.5)
                    }
                    .zIndex(1.0)
                }
                .frame(width: 45)
                .animation(Animation.linear)
            }
        }
    }
    
    //Divide each expense by the largest expense in the array. Then use that amount to determine how much of the graph to fill in.
    
    func getHeightOfBar(maxHeight: CGFloat, amount: Float) -> CGFloat {
        let max = cardManager.getMaxExpences()
        let fraction: CGFloat = CGFloat(amount / max)
        let barHeight = CGFloat(fraction * maxHeight)
        
        return barHeight
    }
}


struct GraphBackgroundView: View {
    var body: some View {
        VStack {
            VStack {
                ForEach (0..<3) { _ in
                    Line()
                        .stroke(style: StrokeStyle(lineWidth: 0.5, dash: [5]))
                        .frame(height: 0.5)
                    Spacer()
                }
            }
            Line()
                .stroke(lineWidth: 0.5)
                .frame(height: 0.5)
        }
        .foregroundColor(ColorConstants.secondary)
    }
}

struct Line: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y:0))
        return path
    }
}

struct ExpenseGraphView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(selectedCard: cards[0])
            .previewDevice("iPhone 11")
    }
}
