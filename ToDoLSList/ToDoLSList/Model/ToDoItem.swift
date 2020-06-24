//
//  ToDoItem.swift
//  ToDoLSList
//
//  Created by Станислав Лемешаев on 21.06.2020.
//  Copyright © 2020 Станислав Лемешаев. All rights reserved.
//

import UIKit

class ToDoItem: ToDoItemable {    
    
    var nameTask: String
    var isCompleted: Bool
    
    var subItems: [ToDoItem]
    
    var subItemsText: String {
        
        if subItems.count == 0 {
            return ""
        }
        
        var completedToDoCount: Int = 0
        for todo in subItems {
            if todo.isCompleted {
                completedToDoCount += 1
            }
        }
        
        if completedToDoCount == 0 {
            return String(subItems.count) + " подзадач"
        }
        else {
            return String(subItems.count) + " подзадач / " + String(completedToDoCount) + "выполнено"
        }
        
    }
    
    var countUncompletedSubTask: Int {
        var uncompletedToDoCount: Int = 0
        for todo in subItems {
            if !todo.isCompleted {
                uncompletedToDoCount += 1
            }
        }
        return uncompletedToDoCount
    }
    
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
    
    func changeState() {
        isCompleted = !isCompleted
    }
    
}
