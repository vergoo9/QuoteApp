import SwiftUI

struct AIQuoteView: View {

    @State private var selectedCategory = "Motivation"
    @State private var customText = ""

    @State private var generatedText = ""
    @State private var isGenerating = false
    @State private var showCursor = true

    let categories = ["Love", "Money", "Motivation", "Life", "Happiness"]

    var onGenerate: (Quote) -> Void

    // MARK: Generate logic
    func generateQuoteText() -> String {

        let basePhrases = [
            "Success comes from action",
            "Love begins within you",
            "Money follows discipline",
            "Happiness is a choice",
            "Life rewards persistence"
        ]

        let extra = customText.isEmpty ? "" : " \(customText)"
        return "\(selectedCategory): \(basePhrases.randomElement()!)\(extra)"
    }

    func startGeneration() {
        isGenerating = true
        generatedText = ""
        showCursor = true

        let fullText = generateQuoteText()
        typeText(fullText) {
            isGenerating = false
        }
    }

    // MARK: ChatGPT typing effect
    func typeText(_ text: String, index: Int = 0, completion: @escaping () -> Void) {

        guard index < text.count else {
            completion()
            return
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.03) {
            let char = text[text.index(text.startIndex, offsetBy: index)]
            generatedText.append(char)

            typeText(text, index: index + 1, completion: completion)
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {

                Picker("Category", selection: $selectedCategory) {
                    ForEach(categories, id: \.self) { Text($0) }
                }
                .pickerStyle(.segmented)

                TextField("Add your idea", text: $customText)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)

                // MARK: Generate Button
                Button {
                    startGeneration()
                } label: {
                    Text(isGenerating ? "Thinking..." : "Generate Quote")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.primary)
                        .foregroundColor(Color(.systemBackground))
                        .cornerRadius(12)
                        .padding(.horizontal)
                }

                // MARK: Chat bubble
                if !generatedText.isEmpty {

                    VStack(alignment: .leading, spacing: 8) {
                        HStack(alignment: .top) {
                            Text(generatedText)
                                .font(.body)
                                .foregroundColor(.primary)

                            Text(showCursor ? "|" : " ")
                                .opacity(0.8)
                                .animation(.easeInOut(duration: 0.5).repeatForever(), value: showCursor)
                        }
                    }
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(16)
                    .padding(.horizontal)
                    .transition(.scale)
                }

                Spacer()
            }
            .navigationTitle("AI Generator")
            .onAppear {
                Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
                    showCursor.toggle()
                }
            }
        }
    }
}


