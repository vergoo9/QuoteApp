//
//  MenuView.swift
//  Quote
//
//  Created by Roman Zhyravlev on 3/16/26.
//
import SwiftUI
struct MenuView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @Binding var isMenuOpen: Bool
    @Binding var selectedCategory: String?
    @Binding var searchText: String
    
    let favoriteCount: Int
    let categories: [String]
    
    let onCategorySelected: (String) -> Void
    let filteredQuotesForMenuSearch: [Quote]
    let onQuoteSelected: (Quote) -> Void
    let getLocalizedText: ([String: String]?) -> String
    
    var body: some View {
        
        VStack {
            
            ClearableTextField(
                placeholder: "Search",
                text: $searchText
            )
            
            if searchText.isEmpty {
                
                List(categories, id: \.self) { category in
                    
                    Button {
                        
                        onCategorySelected(category)
                        
                    } label: {
                        
                        HStack {
                            
                            Text(category)
                                .foregroundColor(.primary)
                            Spacer()
                            
                            if category == "Favorites" {
                                Text("\(favoriteCount)")
                                    .foregroundColor(.gray)
                            }
                            
                        }
                        
                    }
                    
                }
                
            } else {
                
                List(filteredQuotesForMenuSearch) { quote in
                    
                    Button {
                        
                        onQuoteSelected(quote)
                        
                    } label: {
                        
                        VStack(alignment: .leading) {
                            
                            Text(getLocalizedText(quote.text))
                                .foregroundColor(.primary)
                            
                            if let author = quote.author {
                                Text(getLocalizedText(author))
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            
                        }
                        
                    }
                    
                }
                
            }
            
        }
        
    }
}
