//
//  TaskCardView.swift
//  TasksGraphQL
//
//  Created by Ariel Ortiz on 3/23/23.
//

import SwiftUI

struct TaskCardView: View {
    
    let task: Task
    
    var body: some View {
        VStack(alignment: .leading){
            
            Text(task.title)
                .font(.title)
            
            Text(task.description ?? "")
                .font(.caption)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: 80)
        .background(Color(red: 240/255, green: 240/255, blue: 240/255))
        .cornerRadius(10)
    }
}

struct TaskCardView_Previews: PreviewProvider {
    static var previews: some View {
        TaskCardView(task: Task(TaskListQuery.Data.GetAllTask(id: "", title: "")))
    }
}
