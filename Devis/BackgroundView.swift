//
//  quoteBackgroundView.swift
//  Devis
//
//  Created by Youssef Ahab on 20/06/2022.
//

import SwiftUI

struct BackgroundView: View {
    let style: Quote.QuoteStyle
    var body: some View {
        if (style.isGradient) {
            RoundedRectangle(cornerRadius: CGFloat(Constants.cornerRadius))
                .fill(LinearGradient(gradient: Gradient(colors: [style.theme.mainColor,Color.black]), startPoint: .top, endPoint: .bottom))
                .opacity(Double(style.colorOpacity))
                .ignoresSafeArea()
        } else {
            RoundedRectangle(cornerRadius: CGFloat(Constants.cornerRadius))
                .fill(style.theme.mainColor)
                .opacity(Double(style.colorOpacity))
                .ignoresSafeArea()
        }
    }
}

struct quoteBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView(style: Constants.sampleQuotes[1].quoteStyle)
    }
}
