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
                
                
                let updatedToDoListItem = Item()
                if !todoItemTextField.text!.isEmpty {
                    updatedToDoListItem.name = todoItemTextField.text!
                }
                if !todoItemTextField2.text!.isEmpty {
                    updatedToDoListItem.comment = todoItemTextField2.text!
                }
                let item = self.listToDo[indexPath.row]
                
                
                try! self.realm.write({
                    
                    item.name = updatedToDoListItem.name
                    item.comment = updatedToDoListItem.comment
                    
                    tableView.reloadRows(at: [indexPath], with: .automatic)
                })
                
            }
            alertVC.addAction(editAction)
            self.present(alertVC, animated: true, completion: nil)
            
            
        }
        editButton.backgroundColor = UIColor.systemMint
        deleteButton.backgroundColor = UIColor.red
        
        return[editButton, deleteButton]
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
        let cancelAction = UIAlertAction.init(title: "Відмінити", style: .destructive, handler: nil)
        alertVC.addAction(cancelAction)
        
        let addAction = UIAlertAction(title: "Додати", style: .default) { (UIAlertAction) -> Void in
            
            let todoItemTextField = (alertVC.textFields?.first)! as UITextField
            let todoItemTextField2 = (alertVC.textFields?[1])! as UITextField
            
            let newToDoListItem = Item()
            newToDoListItem.name = todoItemTextField.text!
            newToDoListItem.comment = todoItemTextField2.text!
            newToDoListItem.status = "Не розпочато"
            
            try! self.realm.write({
                self.realm.add(newToDoListItem)
                
                self.tableView.insertRows(at: [IndexPath.init(row: self.listToDo.count-1, section: 0)], with: .automatic)
            })
            
        }
        
        alertVC.addAction(addAction)
        present(alertVC, animated: true, completion: nil)
    }
}

