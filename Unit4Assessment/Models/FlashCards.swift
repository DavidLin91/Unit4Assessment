//
//  FlashCards.swift
//  Unit4Assessment
//
//  Created by David Lin on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import Foundation

//struct FlashCards: Codable, Equatable {
//    let cards: [Card]
//}

struct Cards: Codable, Equatable {
    let id: String
    let quizTitle: String
    let facts: [String]
    
    static func getCards(from jsonData: Data) -> [Cards] {
        do {
            let cards = try JSONDecoder().decode([Cards].self, from: jsonData)
            return cards
        } catch {
            print(error)
            return []
        }
    }
    
}
