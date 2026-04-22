//
//  Quote.swift
//  Quote
//
//  Created by Roman Zhyravlev on 3/16/26.
//

import Foundation

struct Quote: Identifiable, Equatable {

    let id: String
    let text: [String:String]
    let author: [String:String]?
    let category: [String:String]

}
