//
//  ToDoListViewController.swift
//  ToDoLSList
//
//  Created by Станислав Лемешаев on 21.06.2020.
//  Copyright © 2020 Станислав Лемешаев. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    var toDoCurrentItem: ToDoItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if toDoCurrentItem == nil {
            toDoCurrentItem = rootItem
        }
        
        navigationItem.title = toDoCurrentItem?.nameTask
        
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        longPressGestureRecognizer.minimumPressDuration = 1
        tableView.addGestureRecognizer(longPressGestureRecognizer)
    }
    
    @objc func handleLongPress(longPress: UILongPressGestureRecognizer) {
        
        let pointOfTouch = longPress.location(in: tableView)
        let indexPath = tableView.indexPathForRow(at: pointOfTouch)
        
        if longPress.state == .began {
            if let indexPath = indexPath {
                let toDoItem = toDoCurrentItem?.subItems[indexPath.row]
                
                let alert = UIAlertController(title: "Редактировать задачу", message: "", preferredStyle: UIAlertController.Style.alert)
                
                alert.addTextField { (textField) in
                    textField.placeholder = "Сделать задачу"
                    textField.text = toDoItem?.nameTask
                }
                
                let alertActionUpdate = UIAlertAction(title: "Обновить", style: UIAlertAction.Style.default) { (alertAction) in
                    
                    if alert.textFields![0].text != "" {
                        toDoItem?.nameTask = alert.textFields![0].text!
                        
                        self.tableView.reloadData()
                        saveData()
                    }
                }
                
                let alertActionCancel = UIAlertAction(title: "Отмена", style: UIAlertAction.Style.cancel) { (alert) in
                    
                }
                
                alert.addAction(alertActionUpdate)
                alert.addAction(alertActionCancel)
                
                present(alert, animated: true, completion: nil)
            }
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (toDoCurrentItem?.subItems.count)!
    }

    @IBAction func pushAction(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Добавить новую задачу", message: "", preferredStyle: UIAlertController.Style.alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Сделать задачу"
        }
        
        let alertActionCreate = UIAlertAction(title: "Создать", style: UIAlertAction.Style.default) { (alertAction) in
            
            if alert.textFields![0].text != "" {
                let newItem = ToDoItem(nameTask: alert.textFields![0].text!)
                
                self.toDoCurrentItem?.addSubItem(subItem: newItem)
                self.tableView.reloadData()
                saveData()
            }
        }
        
        let alertActionCancel = UIAlertAction(title: "Отмена", style: UIAlertAction.Style.cancel) { (alert) in
            
        }
        
        alert.addAction(alertActionCreate)
        alert.addAction(alertActionCancel)
        
        present(alert, animated: true, completion: nil)

    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ToDoViewCell

        let itemForCell = toDoCurrentItem!.subItems[indexPath.row]
        cell.initCell(toDo: itemForCell)
        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            toDoCurrentItem?.removeSubItem(index: indexPath.row)
            saveData()
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let subItem = toDoCurrentItem?.subItems[indexPath.row]
        
        let toDoListVC = storyboard?.instantiateViewController(withIdentifier: "todoSID") as! ToDoListViewController
        toDoListVC.toDoCurrentItem = subItem
        
        navigationController?.pushViewController(toDoListVC, animated: true)
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
