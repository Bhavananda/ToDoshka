//
//  Item.swift
//  ToDoshka
//
//  Created by Bhavananda Das on 05.03.2024.
//

import Foundation
import RealmSwift


class Item: Object {
   @objc dynamic var name: String = ""
   @objc dynamic var comment: String = ""
   @objc dynamic var status: String = ""
}
