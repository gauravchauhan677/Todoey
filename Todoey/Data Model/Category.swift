//
//  Category.swift
//  Todoey
//
//  Created by gaurav chauhan on 03/09/19.
//  Copyright © 2019 gaurav chauhan. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    
    @objc dynamic var name: String = ""
    
    let items = List<Item>()
    
}
