//
//  ToDoTableViewController.swift
//  ToDoApp_W23
//
//  Created by Rania Arbash on 2023-05-23.
//

import UIKit

class ToDoTableViewController: UITableViewController {

    
    var todoList = [ToDo]()
    var uDefaults = UserDefaults.standard
    
    
    var filePath =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appending(path: "myTodos.plist")

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        //todoList = uDefaults.array(forKey: "todos") as? [ToDo] ?? []
        do {
            let dataFromFile = try Data(contentsOf: filePath!)
            let decoder = PropertyListDecoder()
            todoList = try decoder.decode([ToDo].self, from: dataFromFile)
            tableView.reloadData()
        } catch {
            
            print (error)
        }
        
       
        
        
        
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }

    @IBAction func addNewToDo(_ sender: Any) {
        
        let alert = UIAlertController.init(title: "New Task", message: "Enter a New ToDo", preferredStyle: .alert)
        
        
        var aletTextField = UITextField()
        
        alert.addTextField { textField in
            
            textField.placeholder = "Enter A Task"
            aletTextField = textField
            
        }
        
        let saveButton = UIAlertAction(title: "Save", style: .default) { action in
            // code to be run when this button clicked
            print(aletTextField.text ?? "")
            if let goodToDo = aletTextField.text{
                if !(goodToDo.isEmpty){
                    
                    self.todoList.append(ToDo(task: goodToDo, date: Date().description, done: false))
                   
                    self.saveToFile()
                    
                    //  self.uDefaults.set(self.todoList, forKey: "todos")
                    
                }
            }
            
        }
        
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(saveButton)
        present(alert, animated: true)
        
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    todoList[indexPath.row].done = !todoList[indexPath.row].done
//
//        if todoList[indexPath.row].done {
//            todoList[indexPath.row].done = false
//        } else {
//            todoList[indexPath.row].done = true
//        }
        saveToFile()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    func saveToFile(){
        let encoder = PropertyListEncoder()
        do{
            let data =  try encoder.encode(self.todoList)
            try data.write(to: self.filePath!)
            tableView.reloadData()
        } catch{
            
            print (error)
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text = todoList[indexPath.row].task
        cell.detailTextLabel?.text = todoList[indexPath.row].date
        
        cell.accessoryType = todoList[indexPath.row].done ? .checkmark : .none
        
        
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
            todoList.remove(at: indexPath.row)
            saveToFile()
            
        }
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
