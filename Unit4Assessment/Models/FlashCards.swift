//
//  FlashCards.swift
//  Unit4Assessment
//
//  Created by David Lin on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import Foundation

struct FlashCards: Codable {
    let cards: [Card]
}

struct Card: Codable {
    let id: String
    let cardTitle: String
    let facts: [String]
}
