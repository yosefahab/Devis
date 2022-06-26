//
//  QuoteCardList.swift
//  Devis
//
//  Created by Youssef Ahab on 20/06/2022.
//

import SwiftUI

struct CardListView: View {
    @Binding var quotes: [Quote]
    let saveAction: ()->Void
    
    @Environment(\.scenePhase) private var scenePhase
    @State private var newQuoteData: Quote.QuoteData = Quote.QuoteData()
    @State private var newImage: UIImage? = nil
    @State private var isPresentingNewQuoteView: Bool = false
    
    var body: some View {
        List {
            ForEach($quotes) { $quote in
                NavigationLink(destination: QuoteView(quote: $quote)) {
                    CardView(quote: quote)
                }
                .listRowBackground(
                    listRowBackgroundView(quoteStyle: quote.quoteStyle)
                        .opacity(Double(quote.quoteStyle.colorOpacity))
                )
                .listRowSeparatorTint(.white)
            }
            .onDelete(perform: deleteQuote)
        }
        .navigationTitle("Your Quotes")
        .toolbar {
            Button(action: {
                isPresentingNewQuoteView = true
            }) {
                Image(systemName: "plus")
            }
            .accessibilityLabel("New quote")
        }
        .sheet(isPresented: $isPresentingNewQuoteView){
            NavigationView {
                EditQuoteView(data: $newQuoteData, inputImage: $newImage)
                    .navigationTitle("New Quote")
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Dismiss") {
                                newQuoteData = Quote.QuoteData()
                                newImage = nil
                                isPresentingNewQuoteView = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Add") {
                                var tempQuote = Quote(data: newQuoteData)
                                tempQuote.quoteStyle.setImage(image: newImage)
                                quotes.append(tempQuote)
                                newQuoteData = Quote.QuoteData()
                                newImage = nil
                                isPresentingNewQuoteView = false
                                saveAction()
                            }
                        }
                    }
            }
        }
        .onChange(of: scenePhase){ phase in
            if phase == .inactive { saveAction() }
        }
        
    }
    private func deleteQuote(at index: IndexSet){
        quotes.remove(atOffsets: index)
    }
}

struct QuoteCardList_Previews: PreviewProvider {
    static var previews: some View {
        CardListView(quotes: .constant(Constants.sampleQuotes), saveAction: {})
    }
}
