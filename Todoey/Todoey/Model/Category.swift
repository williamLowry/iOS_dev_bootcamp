//
//  Category.swift
//  Todoey
//
//  Created by Will Lowry on 6/25/19.
//  Copyright © 2019 Programmer Alley. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    
    @objc dynamic var name : String = ""
    let items = List<Item>()
    
    
    
}
