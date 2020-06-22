//
//  ToDoViewCell.swift
//  ToDoLSList
//
//  Created by Станислав Лемешаев on 22.06.2020.
//  Copyright © 2020 Станислав Лемешаев. All rights reserved.
//

import UIKit

class ToDoViewCell: UITableViewCell {

    @IBOutlet weak var buttonCheck: UIButton!
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var subItemLabel: UILabel!
    
    @IBAction func pushButtonCheck(_ sender: UIButton) {
        toDoInCell?.changeState()
        
        setCheckButton()
    }
    
    var toDoInCell: ToDoItem?
    
    func initCell(toDo: ToDoItem) {
        toDoInCell = toDo
        taskNameLabel.text = toDoInCell?.nameTask
        subItemLabel.text = toDoInCell?.subItemsText
        
        setCheckButton()
    }
    
    func setCheckButton() {
        if toDoInCell!.isCompleted {
            buttonCheck.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        } else {
            buttonCheck.setImage(UIImage(systemName: "circle"), for: .normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
