//
//  QuoteCard.swift
//  Devis
//
//  Created by Youssef Ahab on 20/06/2022.
//

import SwiftUI

struct CardView: View {
    let quote: Quote
    
    var body: some View {
        VStack{
            Text(quote.type)
                .font(.custom("Courier New",size: 16))
                .padding(.bottom)
                .accessibilityAddTraits(.isHeader)
                .accessibilityLabel("\(quote.type) quote")
            Text(quote.text)
                .font(.custom("Arima Madurai", size: 18).bold())
                .padding(.bottom)
                .lineLimit(1)
                .truncationMode(.tail)
                .accessibilityLabel(quote.text)
            HStack{
                Label(quote.author,systemImage: "person")
                .font(.custom("Copperplate", size: 16))
                .accessibilityLabel("By \(quote.author)")
                Spacer()
                Image(systemName: quote.isFavourite ? "heart.fill" : "heart")
                    .foregroundColor(.red)
                    .accessibilityLabel(quote.isFavourite ? "Favourited quote" : "")
            }
        }
        .padding()
        .foregroundColor(quote.quoteStyle.whiteFont ? .white : .black)
        .accessibilityElement(children: .combine)
    }
}
struct QuoteCard_Previews: PreviewProvider {
    static var quote = Constants.sampleQuotes[3]
    static var previews: some View {
        CardView(quote: quote)
        .previewLayout(.fixed(width: 400, height: 125))
        .background(quote.quoteStyle.theme.mainColor)
    }
}
