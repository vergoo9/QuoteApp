//
//  ClearableTextField.swift
//  Quote
//
//  Created by Roman Zhyravlev on 3/16/26.
//
import SwiftUI
struct ClearableTextField: View {

    let placeholder: String
    @Binding var text: String

    var body: some View {

        HStack {

            TextField(placeholder, text: $text)
                .textFieldStyle(.roundedBorder)

            if !text.isEmpty {

                Button {

                    text = ""

                } label: {

                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)

                }

            }

        }
        .padding(.horizontal)

    }

}
