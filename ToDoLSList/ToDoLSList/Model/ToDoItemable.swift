//
//  ToDoItemable.swift
//  ToDoLSList
//
//  Created by Станислав Лемешаев on 24.06.2020.
//  Copyright © 2020 Станислав Лемешаев. All rights reserved.
//

import Foundation

protocol ToDoItemable: class {
    var nameTask: String { get set }
    
    var isCompleted: Bool { get set }
    
    var subItems: [ToDoItem] { get set }
    
    var subItemsText: String { get }
    
}
