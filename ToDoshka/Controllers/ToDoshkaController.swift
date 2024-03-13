//
//  ViewController.swift
//  ToDoshka
//
//  Created by Bhavananda Das on 05.03.2024.
//

import UIKit
import RealmSwift

class ToDoshkaController: UITableViewController {
    
    var realm: Realm!
    var listToDo: Results<Item>{
        get {
            return realm.objects(Item.self)
        }
    }
    
    @IBOutlet var ToDoshkaTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        realm = try! Realm()
        
        ToDoshkaTableView.register(UINib(nibName: "ToDoshkaCell", bundle: nil), forCellReuseIdentifier: "ToDoshkaCell")
        
        ToDoshkaTableView.rowHeight = UITableView.automaticDimension
        ToDoshkaTableView.estimatedRowHeight = 500
    }
    
    // MARK: - Datasource Method
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listToDo.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoshkaCell", for: indexPath) as! ToDoshkaCell
        let item = listToDo[indexPath.row]
        //
        cell.configure(with: item) { newStatus in
            try! self.realm.write({
                item.status = newStatus.rawValue
                tableView.reloadRows(at: [indexPath], with: .automatic)
            })
        }
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    
    // MARK: - Add Delegate Method
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        
    }
    
    override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        false
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteButton = UITableViewRowAction(style: .normal, title: "Delete") { (rowAction, indexpath)
            in
            let item = self.listToDo[indexPath.row]
            try! self.realm.write ({
                self.realm.delete(item)
            })
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
        }
        
        
        let editButton = UITableViewRowAction(style: .normal, title: "Edit") { (rowAction, indexpath) in
            
            let alertVC = UIAlertController(title: "Зміна", message: "Що хочеш змінити?", preferredStyle: .alert)
            alertVC.addTextField { (UITextField)  in
                UITextField.placeholder = "Нова назва тудухи"
            }
            alertVC.addTextField { (UITextField)  in
                UITextField.placeholder = "Новий опис"
            }
            let cancelAction = UIAlertAction.init(title: "Відмінити", style: .destructive, handler: nil)
            alertVC.addAction(cancelAction)
            
            let editAction = UIAlertAction(title: "Змінити", style: .default) { (UIAlertAction) -> Void in
                let todoItemTextField = (alertVC.textFields?.first)! as UITextField
                let todoItemTextField2 = (alertVC.textFields?[1])! as UITextField
                
                var updatedToDoListItem = Item()
                if let text1 = todoItemTextField.text, !text1.isEmpty {
                    updatedToDoListItem.name = text1
                    let item = self.listToDo[indexPath.row]
                    try! self.realm.write({
                        item.name = updatedToDoListItem.name
                        tableView.reloadRows(at: [indexPath], with: .automatic)
                    }) } else {
                        updatedToDoListItem.name = updatedToDoListItem.name
                        print("Nu wo?")
                    }
                if let text2 = todoItemTextField2.text, !text2.isEmpty {
                    updatedToDoListItem.name = text2
                    let item = self.listToDo[indexPath.row]
                    try! self.realm.write({
                        item.comment = text2
                        tableView.reloadRows(at: [indexPath], with: .automatic)
                    }) } else {
                        updatedToDoListItem.comment = updatedToDoListItem.comment
                        print("Catch your comment")
                    }
            }
            alertVC.addAction(editAction)
            self.present(alertVC, animated: true, completion: nil)
            
        }
        editButton.backgroundColor = UIColor.systemMint
        deleteButton.backgroundColor = UIColor.red
        
        return[deleteButton, editButton]
    }
    
    // MARK: - Adding New Item
    
    
    @IBAction func addButton(_ sender: UIBarButtonItem) {
        
        let alertVC = UIAlertController(title: "Нова Тудуха", message: "Що хочеш додати?", preferredStyle: .alert)
        alertVC.addTextField { (UITextField)  in
            UITextField.placeholder = "Задача"
        }
        alertVC.addTextField { (UITextField)  in
            UITextField.placeholder = "Опис"
        }
        let errorAlert = UIAlertController(title: "Помилка", message: "Пуста таска не дозволена", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) -> Void in
            errorAlert.dismiss(animated: true, completion: nil)
            self.present(alertVC, animated: true, completion: nil)
        }
        errorAlert.addAction(okAction)
        
        let cancelAction = UIAlertAction.init(title: "Відмінити", style: .destructive, handler: nil)
        alertVC.addAction(cancelAction)
        
        let addAction = UIAlertAction(title: "Додати", style: .default) { (UIAlertAction) -> Void in
            
            let todoItemTextField = (alertVC.textFields?.first)! as UITextField
            let todoItemTextField2 = (alertVC.textFields?[1])! as UITextField
            
            
            if let text = todoItemTextField.text, !text.isEmpty
                {
                let newToDoListItem = Item()
                newToDoListItem.name = text
                newToDoListItem.comment = todoItemTextField2.text!
                newToDoListItem.status = "Не розпочато"
                
                try! self.realm.write({
                    self.realm.add(newToDoListItem)
                    
                    self.tableView.insertRows(at: [IndexPath.init(row: self.listToDo.count-1, section: 0)], with: .automatic)
                })
            } else {
                self.present(errorAlert, animated: true, completion: nil )
            }
        }
            alertVC.addAction(addAction)
            present(alertVC, animated: true, completion: nil)
            
        }
    }
    

