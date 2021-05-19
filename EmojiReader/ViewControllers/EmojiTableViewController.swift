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
    
    // настраиваем какие действия должна делать наша EditingStyle при тапе и свайпе
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
    
    //MARK: -  добавляем кастомные кнопки ячейке при свайпе
    /* есть trailingSwipe... для отображения справа
     override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
     <#code#>
     }
     */
    //метод возвращает массив экшенов
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let done = doneAction(at: indexPath)
        let favourite = favouriteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [done, favourite])
    }
    
    //создаю doneAction для массива UISwipeActionsConfiguration
    func doneAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(
            style: .destructive, //как булет выглядеть ячейка (удалится или в нормальном состоянии останется)
            title: "Done" ) { (_, _, isDone) in
            self.objects.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            isDone(true) //означает что на данном этапе действия с кнопкой завершаться и ничего происходить не будет в данной фукции
        }
        action.backgroundColor = .systemGreen
        action.image = UIImage(systemName: "checkmark.circle") //если картинки не будет, то высветится title "Done"
        return action
    }
    
    // создаю fovouriteAction для массива UISwipeActionsConfiguration
    func favouriteAction(at indexPath: IndexPath) -> UIContextualAction {
        var object = objects[indexPath.row] //находим данные обхекта ячейки
        let action = UIContextualAction(
            style: .normal,
            title: "Favoirite") { (_, _, isDone) in
            object.isFavourite.toggle()
            self.objects[indexPath.row] = object
            isDone(true)
        }
        action.backgroundColor = object.isFavourite ? .systemPurple : .systemGray
        action.image = UIImage(systemName: "heart")
        return action
    }
    
    //MARK: - Navigation
    //настрока кнопок save и edit на втором экране
    @IBAction func unwindSegue(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveSegue" else { return }
        guard let newEmojiVC = segue.source as? NewEmojiTableViewController else { return }
        let emoji = newEmojiVC.emoji
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            objects[selectedIndexPath.row] = emoji
            tableView.reloadRows(at: [selectedIndexPath], with: .automatic)
        } else {
            let indexPath = IndexPath(row: objects.count, section: 0)
            objects.append(emoji)
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "editEmoji" else { return }
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let emoji = objects[indexPath.row]
        let navigationVC = segue.destination as! UINavigationController
        guard let newEmojiVC = navigationVC.topViewController as? NewEmojiTableViewController else { return
        }
        newEmojiVC.emoji = emoji
        newEmojiVC.title = "Edit"
        
        
    }
    
}
