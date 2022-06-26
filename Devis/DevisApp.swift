//
//  DevisApp.swift
//  Devis
//
//  Created by Youssef Ahab on 17/06/2022.
//

import SwiftUI

@main
struct DevisApp: App {
    
    @StateObject private var store = QuoteStore()
    @State private var errorWrapper: ErrorWrapper?
 
    var body: some Scene {
        WindowGroup {
            NavigationView {
                CardListView(quotes: $store.quotes){
                    Task {
                        do {
                            try await QuoteStore.save(quotes: store.quotes)
                        } catch {
                            errorWrapper = ErrorWrapper(error: error, guidance: "Error saving quotes")
                        }
                    }
                }
                .task {
                    do {
                        if !store.quotes.isEmpty { try await QuoteStore.save(quotes: store.quotes) }
                        store.quotes = try await QuoteStore.load()
                    } catch {
                        errorWrapper = ErrorWrapper(error: error, guidance: "Error loading quotes")
                    }
                }
                .sheet(item: $errorWrapper, onDismiss: {
                    store.quotes = []
                }) { wrapper in
                    Text(wrapper.guidance)
//                    ErrorView(errorWrapper: wrapper)
                }
            }
        }
    }
}
