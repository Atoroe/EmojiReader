//
//  NewEmojiTableViewController.swift
//  EmojiReader
//
//  Created by Artiom Poluyanovich on 17.05.21.
//

import UIKit

class NewEmojiTableViewController: UITableViewController {
    
    @IBOutlet weak var emojiTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var emoji = Emoji(emoji: "", name: "", description: "", isFavourite: false)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
        updateSaveButtonState()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { 
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "saveSegue" else { return }

        let emoji = emojiTextField.text ?? ""
        let name = nameTextField.text ?? ""
        let description = descriptionTextField.text ?? ""
        
        self.emoji = Emoji(
            emoji: emoji,
            name: name,
            description: description,
            isFavourite: self.emoji.isFavourite)
    }

    @IBAction func textChanged(_ sender: UITextField) {
        updateSaveButtonState()

    }
    
    private func updateSaveButtonState() {
        let emojiText = emojiTextField.text ?? ""
        let nameText = nameTextField.text ?? ""
        let descriptionText = descriptionTextField.text ?? ""
        
        saveButton.isEnabled = !emojiText.isEmpty
                                && !nameText.isEmpty
                                && !descriptionText.isEmpty
    }
    
    private func updateUI() {
        emojiTextField.text = emoji.emoji
        nameTextField.text = emoji.name
        descriptionTextField.text = emoji.description

    }
}