//
//  HomeView.swift
//  TasksGraphQL
//
//  Created by Ariel Ortiz on 3/16/23.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var userViewModel: UserViewModel
    
    @StateObject var vm = TaskViewModel()
    
    @State var showCreateUpdate: Bool = false
    @State var taskUpdate: Task?
    
    var body: some View {
        NavigationStack{
            ScrollView{
                ForEach(vm.listTasks){ task in
                    
                    NavigationLink {
                        TaskDetailView(task: task)
                    } label: {
                        TaskCardView(task: task)
                            .padding(.horizontal)
                            .contextMenu {
                                    Button {
                                        taskUpdate = task
                                        showCreateUpdate = true
                                    } label: {
                                        Text("Edit")
                                    }

                                    Button {
                                        vm.deleteTask(id: task.id)
                                    } label: {
                                        Text("Delete")
                                    }
                                }
                    }

                    
                   
                }
            }
            .sheet(isPresented: $showCreateUpdate, content: {
                CreateUpdateTaskView(task: $taskUpdate)
                    .environmentObject(vm)
            })
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Add") {
                        showCreateUpdate = true
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Logout") {
                        userViewModel.logout()
                    }
                }
            }
            .navigationTitle("Task")
        }
        
        
        .onAppear{
            vm.getAllTasks()
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
