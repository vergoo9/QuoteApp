//
//  ContentView.swift
//  Quote
//
//  Created by Roman Zhyravlev on 3/16/26.
//
import SwiftUI
struct ContentView: View {

    @Environment(\.colorScheme) var colorScheme

    // MARK: State

    @State private var currentQuote: Quote?
    @State private var favoriteQuotes: [Quote] = []
    @State private var isFavorite = false

    @State private var isMenuOpen = false
    @State private var isCategoryQuotesOpen = false
    @State private var selectedCategory: String?
    @State private var isAIViewOpen = false
    @State private var searchText = ""

    private let favoritesKey = "favoriteQuotesIDs"

    let categories = [
        "Favorites",
        "Love",
        "Wisdom",
        "Money",
        "Motivation",
        "Life",
        "Happiness"
    ]

    // MARK: Helpers

    func getLocalizedText(_ dict: [String:String]?) -> String {

        let lang = Locale.current.languageCode ?? "en"
        return dict?[lang] ?? dict?["en"] ?? ""

    }

    func saveFavorites() {

        UserDefaults.standard.set(
            favoriteQuotes.map{$0.id},
            forKey: favoritesKey
        )

    }

    func loadFavorites() {

        let ids = UserDefaults.standard.stringArray(
            forKey: favoritesKey
        ) ?? []

        favoriteQuotes = quotes.filter{
            ids.contains($0.id)
        }

    }

    func updateIsFavorite() {

        guard let currentQuote else { return }

        isFavorite = favoriteQuotes.contains{
            $0.id == currentQuote.id
        }

    }
    func toggleFavorite() {

        UIImpactFeedbackGenerator(style: .medium).impactOccurred()

        guard let currentQuote else { return }

        if let index = favoriteQuotes.firstIndex(where: { $0.id == currentQuote.id }) {

            favoriteQuotes.remove(at: index)
            isFavorite = false

        } else {

            favoriteQuotes.append(currentQuote)
            isFavorite = true

        }

        saveFavorites()
    }

    var filteredQuotes:[Quote] {

        let base:[Quote]

        if selectedCategory == "Favorites" {

            base = favoriteQuotes

        } else if let selectedCategory {

            base = quotes.filter{
                $0.category["en"] == selectedCategory
            }

        } else {

            base = quotes

        }

        if searchText.isEmpty { return base }

        return base.filter{

            getLocalizedText($0.text)
                .localizedCaseInsensitiveContains(searchText)

            ||

            getLocalizedText($0.author)
                .localizedCaseInsensitiveContains(searchText)

        }

    }

    // MARK: UI

    var body: some View {

        NavigationStack {

            VStack {

                Spacer()

                if let quote = currentQuote {

                    VStack(spacing:12) {

                        Text(getLocalizedText(quote.text))
                            .font(.title)
                            .multilineTextAlignment(.center)
                            .padding()

                        if let author = quote.author {

                            Text(getLocalizedText(author))
                                .foregroundColor(.gray)

                        }

                    }

                }

                Spacer()

                Button("Next Quote") {

                    currentQuote = filteredQuotes.randomElement()
                    updateIsFavorite()

                }
                .foregroundColor(colorScheme == .dark ? .white : .black)
                .padding(.bottom,30)

            }

            .toolbar {

                ToolbarItem(placement: .navigationBarLeading) {

                    Button {

                        isMenuOpen = true

                    } label: {

                        Image(systemName: "line.3.horizontal")

                    }

                }

                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    
                    
                    Button {
                        isAIViewOpen = true
                    } label: {
                        Image(systemName: "brain.head.profile")
                    }

                    Button(action: toggleFavorite) {

                        Image(systemName: isFavorite ? "bookmark.fill" : "bookmark")
                            .scaleEffect(isFavorite ? 1.2 : 1.0)
                            .animation(.spring(), value: isFavorite)

                    }

                                            Button {

                                                UIImpactFeedbackGenerator(style: .medium)
                                                    .impactOccurred()

                                                guard let quote = currentQuote else { return }

                                                var text = getLocalizedText(quote.text)

                                                if let author = quote.author {

                                                    text += "\n— " + getLocalizedText(author)

                                                }

                                                UIPasteboard.general.string = text

                                            } label: {

                                                Image(systemName: "doc.on.doc")

                                            }

                                            Button {

                                                guard let quote = currentQuote else { return }

                                                let text = getLocalizedText(quote.text)

                                                let vc = UIActivityViewController(
                                                    activityItems: [text],
                                                    applicationActivities: nil
                                                )

                                                UIApplication.shared.connectedScenes
                                                    .compactMap {
                                                        ($0 as? UIWindowScene)?
                                                            .windows.first?.rootViewController
                                                    }
                                                    .first?
                                                    .present(vc, animated: true)

                                            } label: {

                                                Image(systemName: "square.and.arrow.up")

                                            }

                                        }

                                    }

                                    .sheet(isPresented: $isMenuOpen) {

                                        MenuView(
                                            isMenuOpen: $isMenuOpen,
                                            selectedCategory: $selectedCategory,
                                            searchText: $searchText,
                                            favoriteCount: favoriteQuotes.count,
                                            categories: categories,
                                            onCategorySelected: {

                                                selectedCategory = $0
                                                isMenuOpen = false
                                                isCategoryQuotesOpen = true

                                            },
                                            filteredQuotesForMenuSearch: filteredQuotes,
                                            onQuoteSelected: {
                                                currentQuote = $0
                                                updateIsFavorite()
                                                isMenuOpen = false
                                            },
                                            getLocalizedText: getLocalizedText
                                        )

                                        .presentationDetents([.fraction(0.5)])

                                    }
                                    .sheet(isPresented: $isAIViewOpen) {
                                        AIQuoteView { newQuote in
                                            currentQuote = newQuote
                                            updateIsFavorite()
                                            isAIViewOpen = false
                                        }
                                    }
            
                                    .sheet(isPresented: $isCategoryQuotesOpen) {

                                        if let selectedCategory {

                                            CategoryQuotesView(
                                                category: selectedCategory,
                                                favoriteQuotes: $favoriteQuotes,
                                                isPresented: $isCategoryQuotesOpen,
                                                getLocalizedText: getLocalizedText
                                            )

                                        }

                                    }

                                    .onAppear {

                                        loadFavorites()
                                        currentQuote = quotes.randomElement()
                                        updateIsFavorite()

                                    }

                                }

                            }

                        }
