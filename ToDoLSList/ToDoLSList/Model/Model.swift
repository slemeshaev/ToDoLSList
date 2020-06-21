//
//  Model.swift
//  ToDoLSList
//
//  Created by Станислав Лемешаев on 21.06.2020.
//  Copyright © 2020 Станислав Лемешаев. All rights reserved.
//

import UIKit

// путь сохранения данных
var pathForSaveData: String {
    let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]+"/data.plist"
    print(path)
    return path
}

var rootItem: ToDoItem?

// загрузка данных
func loadData() {
    if let dict = NSDictionary(contentsOfFile: pathForSaveData) {
        rootItem = ToDoItem(dictionary: dict)
    } else {
        rootItem = ToDoItem(nameTask: "ToDo")
    }
}

// сохранение данных
func saveData() {
    rootItem?.dictionary.write(toFile: pathForSaveData, atomically: true)
}
    


