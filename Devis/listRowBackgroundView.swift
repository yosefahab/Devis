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
        VStack{
            if quoteStyle.isGradient {
                AnyView(
                    LinearGradient(
                        gradient: Gradient(colors: [quoteStyle.theme.mainColor, Color.black]),
                        startPoint: .leading, endPoint: .trailing
                    )
                )
            }
            else {
                quoteStyle.whiteFont ? AnyView(Color.black) : AnyView(Color.white)
            }
        }
        .cornerRadius(Constants.roundedRadius)
        .padding([.top,.bottom],5)
    }
}

struct tempView_Previews: PreviewProvider {
    static var previews: some View {
        listRowBackgroundView(quoteStyle: Constants.sampleQuotes[1].quoteStyle)
    }
}
