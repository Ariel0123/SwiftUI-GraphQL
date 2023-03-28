//
//  TaskViewModel.swift
//  TasksGraphQL
//
//  Created by Ariel Ortiz on 8/9/22.
//

import Foundation
import UIKit
import Apollo

class TaskViewModel: ObservableObject{
    
    @Published public var listTasks = [Task]()
    
    private var apiCaller: APICallerDelegate
    
    init(apiCaller: APICallerDelegate = APICaller.shared){
        self.apiCaller = apiCaller
    }
    
    public func getAllTasks(){
        apiCaller.getAllTasks(completion: { [weak self] result in
            switch result {
            case .success(let list):
                self?.listTasks = list
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        })
    }
   
 
    
    public func createTask(task: TaskInput){
       
        apiCaller.createTask(task: task, completion: { [weak self] result in
            if result{
                self?.getAllTasks()
            }
        })
    }
    
    public func updateTask(id: String, task: TaskInput){
        apiCaller.updateTask(id: id, task: task, completion: { [weak self] result in
            if result{
                self?.getAllTasks()
            }
        })
    }
    
    public func deleteTask(id: String){
        apiCaller.deleteTask(id: id, completion: { [weak self] result in
            if result{
                self?.getAllTasks()
            }
        })
    }
    

   
    
}
