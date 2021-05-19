//
//  Emoji.swift
//  EmojiReader
//
//  Created by Artiom Poluyanovich on 17.05.21.
//

struct Emoji {
    var emoji: String
    var name: String
    var description: String
    var isFavourite: Bool
    var new: Optional<Int> = nil
}

extension Emoji {
    static func getEmojis() -> [Emoji] {
        var emojis: [Emoji] = []
        for index in 0..<EmojiManager.shared.emojis.count {
            let emoji = Emoji(
                emoji: EmojiManager.shared.emojis[index],
                name: EmojiManager.shared.names[index],
                description: EmojiManager.shared.descriptions[index],
                isFavourite: EmojiManager.shared.isFavorites[index])
            emojis.append(emoji)
        }
        return emojis
    }
}
