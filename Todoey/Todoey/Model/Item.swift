//
//  Item.swift
//  Todoey
//
//  Created by Will Lowry on 6/25/19.
//  Copyright © 2019 Programmer Alley. All rights reserved.
//

import Foundation
import RealmSwift


class Item: Object {
    
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
