//
//  Task.swift
//  TasksGraphQL
//
//  Created by Ariel Ortiz on 8/9/22.
//

import Foundation

struct Task: Identifiable, Decodable{
    let id: String
    let title: String
    let description: String?
    
    
    init(_ task: TaskListQuery.Data.GetAllTask?){
        self.id = task?.id ?? ""
        self.title = task?.title ?? ""
        self.description = task?.description ?? ""
        
    }
}
