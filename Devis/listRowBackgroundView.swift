//
//  tempView.swift
//  Devis
//
//  Created by Youssef Ahab on 22/06/2022.
//

import SwiftUI

struct listRowBackgroundView: View {
    let quoteStyle: Quote.QuoteStyle
    var body: some View {
        if quoteStyle.isGradient {
            AnyView(
                LinearGradient(
                    gradient: Gradient(colors: [quoteStyle.theme.mainColor, Color.black]),
                    startPoint: .leading, endPoint: .trailing
                )
                .cornerRadius(Constants.cornerRadius)
                .padding([.top,.bottom],5)
            )
        } else {
            quoteStyle.theme.mainColor
                .cornerRadius(Constants.cornerRadius)
                .padding([.top,.bottom],5)
        }
    }
}

struct tempView_Previews: PreviewProvider {
    static var previews: some View {
        listRowBackgroundView(quoteStyle: Constants.sampleQuotes[1].quoteStyle)
    }
}
