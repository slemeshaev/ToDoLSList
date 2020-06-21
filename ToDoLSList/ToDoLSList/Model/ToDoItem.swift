//
//  ToDoItem.swift
//  ToDoLSList
//
//  Created by Станислав Лемешаев on 21.06.2020.
//  Copyright © 2020 Станислав Лемешаев. All rights reserved.
//

import UIKit

class ToDoItem {
    
    var nameTask: String
    var isCompleted: Bool
    
    var subItems: [ToDoItem]
    
    init(nameTask: String) {
        self.nameTask = nameTask
        self.isCompleted = false
        
        self.subItems = []
    }
    
    init(dictionary: NSDictionary) {
        self.nameTask = dictionary.object(forKey: "nameTask") as! String
        self.isCompleted = dictionary.object(forKey: "isCompleted") as! Bool
        self.subItems = []
        
        let arraySubToDos = dictionary.object(forKey: "arraySubToDos") as! NSArray
        for subToDoDict in arraySubToDos {
            self.subItems.append(ToDoItem(dictionary: subToDoDict as! NSDictionary))
        }
    }
    
    var dictionary: NSDictionary {
        var arraySubToDos = NSArray()
        for subitem in subItems {
            arraySubToDos = arraySubToDos.adding(subitem.dictionary) as NSArray
        }
        
        let dictionary = NSDictionary(objects: [nameTask, isCompleted, arraySubToDos], forKeys: ["nameTask" as NSCopying, "isCompleted" as NSCopying, "arraySubToDos" as NSCopying])
        return dictionary
    }
    
    func addSubItem(subItem: ToDoItem) {
        subItems.append(subItem)
    }
    
    func removeSubItem(index: Int) {
        subItems.remove(at: index)
    }
    
}
