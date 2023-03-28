//
//  TaskDetailView.swift
//  TasksGraphQL
//
//  Created by Ariel Ortiz on 3/23/23.
//

import SwiftUI

struct TaskDetailView: View {
    
    let task: Task
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading){
                
                Text(task.title)
                    .font(.title)
                
                Text(task.description ?? "")
                    .font(.caption)
                
                Spacer()
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct TaskDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TaskDetailView(task: Task(TaskListQuery.Data.GetAllTask(id: "", title: "")))
    }
}
