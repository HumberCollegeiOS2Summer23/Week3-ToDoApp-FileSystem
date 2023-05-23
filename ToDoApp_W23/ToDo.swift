//
//  ToDo.swift
//  ToDoApp_W23
//
//  Created by Rania Arbash on 2023-05-23.
//

import Foundation

class ToDo : Codable{
    
    var task : String
    var date : String
    var done : Bool
    
    init(task: String, date: String, done: Bool) {
        self.task = task
        self.date = date
        self.done = done
    }
}
