//
//  EmojiManager.swift
//  EmojiReader
//
//  Created by Artiom Poluyanovich on 17.05.21.
//

import Foundation

class EmojiManager {
    static let shared = EmojiManager()
    
    let emojis = ["🥰", "⚽️", "🐱"]
    let names = ["Love", "Football", "Cat"]
    let descriptions = [
            "Let's love each other",
            "Let's play football together",
            "Cat is the cutest animal"
            ]
    let isFavorites = [false, false, false]
    
    private init() {}
}
