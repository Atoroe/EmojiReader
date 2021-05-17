//
//  EmojiTableViewController.swift
//  EmojiReader
//
//  Created by Artiom Poluyanovich on 16.05.21.
//

import UIKit

class EmojiTableViewController: UITableViewController {
    
    private var objects = Emoji.getEmojis()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        title = "Emoji Reader"
        navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    
    /* если одна секция то можно удалить метод
       override func numberOfSections(in tableView: UITableView) -> Int {
             1
       }
     */
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        objects.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "emojiCell", for: indexPath) as! EmojiTableViewCell
        let object = objects[indexPath.row]
        cell.setCell(from: object)
        return cell
    }
    
    /* Настройка стандартной ячейки через defaultContentConfiguration()
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "сell", for: indexPath)
        let object = objects[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = object.name
        content.secondaryText = object.description
        cell.contentConfiguration = content
        return cell
    }
    */
    
    //MARK: - Table view delegate
    
    //MARK: - настроили удаление ячеек
    // выбираем EditingStyle кнопки Edit
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        // .insert - кнопака "добавить"
        // .none - будт пусто
        .delete // "удалить" установлен по дефолту
        
        /* возвращаем несколько стилей
        if indexPath.row % 2 == 0 {
            return .delete
        } else {
            return .insert
        }
         */
    }
    
    // настраиваем какие действия должна делать наша EditingStyle при тапе
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade) //удаляет анимированно ячейку
        }
    }
    
    //MARK: - настраиваем перетягивание ячеек в таблице
    //добавляем клавишу перетягивания ячейке
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    // пишем логику что дожно происходить при перемещении
    // sourceIndexPath - индлекс ячейки откуда начали перемещать
    // destinationIndexPath - индекс ячейки куда переместили
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedEmoji = objects.remove(at: sourceIndexPath.row) //зафиксировал удаленные данные из массива по sourceIndexPath
        objects.insert(movedEmoji, at: destinationIndexPath.row) //вставили удаленный элемент в новое место назначения по destinationIndexPath
        tableView.reloadData() //перезашружаем таблицу
        
    }
    
    
}
