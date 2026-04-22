//
//  CategoryQuotesView.swift
//  Quote
//
//  Created by Roman Zhyravlev on 3/16/26.
//
import SwiftUI

struct CategoryQuotesView: View {

    let category: String

    @Binding var favoriteQuotes: [Quote]
    @Binding var isPresented: Bool
    @State private var searchText = ""

    let getLocalizedText: ([String:String]?) -> String

    var filteredQuotesInCategory: [Quote] {

        let base = category == "Favorites"
        ? favoriteQuotes
        : quotes.filter { $0.category["en"] == category }

        if searchText.isEmpty {
            return base
        }

        return base.filter {
            getLocalizedText($0.text).localizedCaseInsensitiveContains(searchText) ||
            getLocalizedText($0.author).localizedCaseInsensitiveContains(searchText)
        }

    }

    var body: some View {

        NavigationStack {

            VStack {

                ClearableTextField(
                    placeholder: "Search",
                    text: $searchText
                )

                List(filteredQuotesInCategory) { quote in

                    VStack(alignment: .leading, spacing:6) {

                        Text(getLocalizedText(quote.text))
                            .foregroundColor(.primary)

                        if let author = quote.author {

                            Text(getLocalizedText(author))
                                .font(.caption)
                                .foregroundColor(.gray)

                        }

                    }
                    .padding(.vertical,8)

                }

            }

            .toolbar {

                ToolbarItem(placement: .navigationBarLeading) {

                    Button("Close") {
                        isPresented = false
                    }

                }

            }

        }

    }

}
