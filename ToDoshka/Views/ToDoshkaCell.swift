//
//  ToDoshkaCell.swift
//  ToDoshka
//
//  Created by Bhavananda Das on 06.03.2024.
//

import UIKit
import RealmSwift

enum ToDoStatus: String {
  case notStarted = "Не розпочато"
  case inProgress = "У процесі"
  case done = "Виконано"
}

class ToDoshkaCell: UITableViewCell {
    
    let realm: Realm! = try! Realm()
    
    @IBOutlet  weak var nameOfTask: UILabel!
    @IBOutlet  weak var commentOfTask: UILabel!
    @IBOutlet private weak var statusButton: UIButton!
    
    
  func configure(with item: Item, onStatusChange: @escaping (ToDoStatus) -> Void) {
    guard let status = ToDoStatus(rawValue: item.status) else { return }
    
    let variantsStatus = [
      UIAction(title: "Не розпочато",
               image: UIImage(systemName: "octagon"),
               state: status == .notStarted ? .on : .off,
               handler: { _ in
       
        onStatusChange(.notStarted)
        print("Не розпочато")
      }),
      UIAction(title: "У процесі",
               image: UIImage(systemName: "octagon.bottomhalf.filled"),
               state: status == .inProgress ? .on : .off,
               handler: { _ in
        
        onStatusChange(.inProgress)
        print("У процесі")
      }),
      UIAction(title: "Виконано",
               image: UIImage(systemName: "octagon.fill"),
               state: status == .done ? .on : .off,
               handler: { _ in
        
        onStatusChange(.done)
        print("Виконано")
      })
    ]
        
        let menu = UIMenu(title: "", image: UIImage(systemName: "arrow.down"), children: variantsStatus)
        self.statusButton.menu = menu
        self.statusButton.showsMenuAsPrimaryAction = true
        self.statusButton.changesSelectionAsPrimaryAction = true
    }
  }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//        
//        
//    }


