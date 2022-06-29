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
    @State private var sortedByFav: Bool = false
    @State private var searchText: String = ""
    
    var body: some View {
        List{
            ForEach($quotes) { $quote in
                if isFiltered(quote: quote) {
                    NavigationLink(destination: QuoteView(quote: $quote)) {
                        CardView(quote: quote)
                    }
                    .listRowBackground(listRowBackgroundView(quoteStyle: quote.quoteStyle))
                }
            }
            .onDelete(perform: deleteQuote)
        }
        .navigationBarTitle("Your Quotes", displayMode: .inline)
        .toolbar {
            ToolbarItem {
                Menu(content: {
                    Button(action: sortByDefault) {
                        HStack {
                            if (!sortedByFav){ Image(systemName: "checkmark.circle") }
                            Text("Unsorted")
                        }
                    }
                    Button(action: sortByFav) {
                        HStack {
                            if (sortedByFav) { Image(systemName: "checkmark.circle") }
                            Text("Sort by Favourites")
                        }
                    }
                }) {
                    Image(systemName: "ellipsis.circle")
                }
            }
            ToolbarItem(placement: .bottomBar) {
                HStack {
                    Image(systemName: "magnifyingglass")
                    TextField("Search", text: $searchText)
                        .textFieldStyle(.roundedBorder)
                        .accessibilityLabel("Search for a quote")
                    Button(action: { isPresentingNewQuoteView = true }) {
                        Image(systemName: "plus.circle.fill")
                    }
                    .accessibilityLabel("New quote")
                }
            }
        }
        .sheet(isPresented: $isPresentingNewQuoteView) {
            NavigationView {
                EditQuoteView(data: $newQuoteData, inputImage: $newImage)
                    .navigationBarTitle("New Quote", displayMode: .inline)
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
                                quotes.insert(tempQuote, at: 0)
                                newQuoteData = Quote.QuoteData()
                                newImage = nil
                                isPresentingNewQuoteView = false
                                saveAction()
                            }
                        }
                    }
            }
        }
        .onChange(of: scenePhase) { phase in
            sortedByFav ? sortByFav() : sortByDefault()
            if phase == .inactive { saveAction() }
        }
    }
    private func deleteQuote(at index: IndexSet) {
        quotes.remove(atOffsets: index)
        saveAction()
    }
    private func sortByFav() {
        sortedByFav = true
        quotes.sort(by: { $0.isFavourite && !$1.isFavourite})
    }
    private func sortByDefault() {
        sortedByFav = false
        quotes.sort(by: { $0.id.hashValue > $1.id.hashValue })
    }
    private func isFiltered(quote: Quote) -> Bool {
        return searchText.isEmpty || quote.text.lowercased().contains(searchText.lowercased()) || quote.author.lowercased().contains(searchText.lowercased()) || quote.type.lowercased().contains(searchText.lowercased())
    }
}

struct QuoteCardList_Previews: PreviewProvider {
    static var previews: some View {
        CardListView(quotes: .constant(Constants.sampleQuotes), saveAction: {})
    }
}
