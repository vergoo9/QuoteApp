//
//  QuoteViewModel.swift
//  Quote
//
//  Created by Roman Zhyravlev on 4/21/26.
//

import SwiftUI
import Combine
class QuoteViewModel: ObservableObject {

    @Published var currentQuote: Quote?
    @Published var favorites: [Quote] = []

    func toggleFavorite(_ quote: Quote) {
        if let index = favorites.firstIndex(where: { $0.id == quote.id }) {
            favorites.remove(at: index)
        } else {
            favorites.append(quote)
        }
    }

    func isFavorite(_ quote: Quote) -> Bool {
        favorites.contains(where: { $0.id == quote.id })
    }

    func setRandom(from quotes: [Quote]) {
        currentQuote = quotes.randomElement()
    }
}
