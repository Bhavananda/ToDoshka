//
//  Item.swift
//  ToDoshka
//
//  Created by Bhavananda Das on 05.03.2024.
//

import Foundation
import RealmSwift

//enum TaskStatus: String {
//    case done
//    case inProcess
//    case notDone
//}

class Item: Object {
   @objc dynamic var name: String = ""
   @objc dynamic var comment: String = ""
//    @objc dynamic var done: Bool = false
   @objc dynamic var status: String = ""
}
