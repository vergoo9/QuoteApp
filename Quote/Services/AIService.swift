//
//  AIService.swift
//  Quote
//
//  Created by Roman Zhyravlev on 4/21/26.
//

import Foundation

class AIService {

    func generateQuote(category: String, prompt: String) -> String {

        let templates = [
            "Success comes from consistency",
            "Discipline creates freedom",
            "Your mindset defines your future",
            "Action beats intention",
            "Growth requires discomfort"
        ]

        let base = templates.randomElement() ?? "Stay consistent"

        if prompt.isEmpty {
            return "\(category): \(base)"
        } else {
            return "\(category): \(base) • \(prompt)"
        }
    }
}
