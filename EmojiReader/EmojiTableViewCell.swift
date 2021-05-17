//
//  EmojiTableViewCell.swift
//  EmojiReader
//
//  Created by Artiom Poluyanovich on 17.05.21.
//

import UIKit

class EmojiTableViewCell: UITableViewCell {
    
    @IBOutlet weak var emojiLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        descriptionLabel.textColor = .systemGray
    }
    
    func setCell(from object: Emoji) {
        emojiLabel.text = object.emoji
        nameLabel.text = object.name
        descriptionLabel.text = object.description
    }
}
