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
    
    @State private var searchText = ""
    
    private var filteredQuotes: [Quote] {
       if searchText.isEmpty { return quotes }
        else { return quotes.filter { $0.text.contains(searchText) } }
   }
    
    var body: some View {
        List{
            ForEach($quotes) { $quote in
                NavigationLink(destination: QuoteView(quote: $quote)) {
                    CardView(quote: quote)
                }
                .searchable(text: $searchText)
                .listRowBackground(listRowBackgroundView(quoteStyle: quote.quoteStyle))
//                .listRowSeparatorTint(.white)
            }
            .onDelete(perform: deleteQuote)
        }
        .navigationBarTitle("Your Quotes", displayMode: .inline)
//        .navigationTitle("Your Quotes")
        .toolbar{
            ToolbarItem{
                Menu(content: {
                    Button(action: sortByDefault){
                        HStack{
                            if (!sortedByFav){ Image(systemName: "checkmark.circle") }
                            Text("Unsorted")
                        }
                    }
                    Button(action: sortByFav){
                        HStack{
                            if (sortedByFav){ Image(systemName: "checkmark.circle") }
                            Text("Sort by Favourites")
                        }
                    }
                }) {
                    Image(systemName: "ellipsis.circle")
                }
            }
            ToolbarItem(placement: .bottomBar) {
                Button(action: {
                    isPresentingNewQuoteView = true
                }) {
                    Image(systemName: "plus.circle.fill")
                }
                .accessibilityLabel("New quote")
            }
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
        .onChange(of: scenePhase){ phase in
            if phase == .inactive { saveAction() }
        }
    }
    private func deleteQuote(at index: IndexSet){
        quotes.remove(atOffsets: index)
    }
    private func sortByFav(){
        sortedByFav = true
        quotes.sort(by: { $0.isFavourite && !$1.isFavourite})
    }
    private func sortByDefault(){
        sortedByFav = false
        quotes.sort(by: { $0.id != $1.id})
    }
    private func searchQuotes(for text: String){
        searchText = text
    }
}

struct QuoteCardList_Previews: PreviewProvider {
    static var previews: some View {
        CardListView(quotes: .constant(Constants.sampleQuotes), saveAction: {})
    }
}
