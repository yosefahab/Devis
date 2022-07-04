//
//  Constants.swift
//  Devis
//
//  Created by Youssef Ahab on 17/06/2022.
//

import SwiftUI

struct Constants{
    
    static let appName: String = "Devis"

    static let cornerRadius: CGFloat = 16.0
    
    static let quoteViewSFSize: CGFloat = 30
    static let quoteViewMinScaleFactor: CGFloat = 0.3
    static let quoteViewLineSpacing: CGFloat = 10
    static let quoteViewImgBlur: CGFloat = 2.0
    static let quoteViewTextFontSize: CGFloat = 23
    static let quoteViewFontSize: CGFloat = 23
    
    static let listFontSize: CGFloat = 16
    static let listQuoteTextSize: CGFloat = 18
    
    static let typeFont: String = "Courier New"
    static let textFont: String = "Arima Madurai"
    static let authorFont: String = "Copperplate"
    
    static let heart: String = "heart"
    static let heartFill: String = "heart.fill"
    static let camera: String = "camera"
    
    static let sampleQuotes: [Quote] = [Quote(type: "Motivational",
                                              quote: "We suffer not from the events in our lives,\n but from our judgement about them//We suffer not from the events in our lives,\n but from our judgement about themWe suffer not from the events in our lives,\n but from our judgement about themWe suffer not from the events in our lives,\n but from our judgement about themWe suffer not from the events in our lives,\n but from our judgement about them",
                                              author: "Epictetus",
                                              isFavourite: false,
                                              quoteStyle: Quote.QuoteStyle(theme: .white, isGradient: false, whiteFont: false)),
                                        Quote(type: "Inspirational",
                                              quote: "Nowadays people know the price of everything and the value of nothing",
                                              author: "lord henry/Oscar Wilde",
                                              isFavourite: true,
                                              quoteStyle: Quote.QuoteStyle(theme: .oxblood, isGradient: true)),
                                        Quote(type: "Inspirational",
                                              quote: "The crowd is untruth",
                                              author: "Kierkegaard",
                                              isFavourite: true,
                                              quoteStyle: Quote.QuoteStyle(theme: .indigo, isGradient: true)),
                                        Quote(type: "Inspirational",
                                              quote: "Existence precedes essence",
                                              author: "Jean-Paul Sartre",
                                              isFavourite: false,
                                              quoteStyle: Quote.QuoteStyle(theme: .black, isGradient: false))]
}
