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
        VStack {
            Text(quote.type)
                .font(.custom(Constants.typeFont, size: Constants.listFontSize))
                .padding(.bottom)
                .accessibilityAddTraits(.isHeader)
                .accessibilityLabel("\(quote.type) quote")
            Text(quote.text)
                .font(.custom(Constants.textFont, size: Constants.listQuoteTextSize).bold())
                .padding(.bottom)
                .truncationMode(.tail)
                .accessibilityLabel(quote.text)
            HStack {
                Label(quote.author,systemImage: "person")
                    .font(.custom(Constants.authorFont, size: Constants.listFontSize))
                .accessibilityLabel("By \(quote.author)")
                Spacer()
                Image(systemName: quote.isFavourite ? Constants.heartFill : Constants.heart)
                    .foregroundColor(.red)
                    .accessibilityLabel(quote.isFavourite ? "Favourited quote" : "")
            }
            .padding(.bottom,0.2)
        }
        .lineLimit(1)
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
