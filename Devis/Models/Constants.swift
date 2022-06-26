//
//  Constants.swift
//  Devis
//
//  Created by Youssef Ahab on 17/06/2022.
//

struct Constants{
    static let roundedRectRadius: Float = 16.0
    static let SFSize: Float = 30
    
    enum types: String, CaseIterable, Identifiable{
        case Motivational
        case Inspirational

        var id: String { return self.rawValue }
    }
    static let sampleQuotes: [Quote] = [Quote(type: "Motivational",
                                              quote: "We suffer not from the events in our lives,\n but from our judgement about them//We suffer not from the events in our lives,\n but from our judgement about themWe suffer not from the events in our lives,\n but from our judgement about themWe suffer not from the events in our lives,\n but from our judgement about themWe suffer not from the events in our lives,\n but from our judgement about them",
                                              author: "Epictetus",
                                              isFavourite: false,
                                              quoteStyle: Quote.QuoteStyle(theme: .teal, isGradient: false, whiteFont: false)),
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
                                              quoteStyle: Quote.QuoteStyle(theme: .magenta, isGradient: false))]
}
