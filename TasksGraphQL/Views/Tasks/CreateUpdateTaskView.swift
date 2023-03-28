//
//  CreateUpdateTaskView.swift
//  TasksGraphQL
//
//  Created by Ariel Ortiz on 3/23/23.
//

import SwiftUI

struct CreateUpdateTaskView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var vm: TaskViewModel
    
    @Binding var task: Task?
    
    @State private var title: String = ""
    @State private var description: String = ""
    
    @State private var errorMessage: String = ""
    @State private var showError: Bool = false
    
    
    var body: some View {
        VStack{
            Text(task == nil ? "Create" : "Update")
                .font(.title)
                .padding(.vertical)
            
            Divider()
            
            VStack{
                TextField("Title", text: $title)
                    .textFieldStyle(.roundedBorder)
                
                
                TextField("Description", text: $description, axis: .vertical)
                    .textFieldStyle(.roundedBorder)
                    
            }.padding(.bottom)
            
            Button(action: {
                save()
            }, label: {
                Text("Save")
                    .foregroundColor(.white)
            })
            .padding()
            .background(.blue)
            .clipShape(Capsule())
            
            Spacer()
            
        }
        .padding()
        .alert(isPresented: $showError) {
                   Alert(title: Text("Alert"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
               }
        .onAppear{
            if let result = task{
                self.title = result.title
                self.description = result.description ?? ""
            }
        }
        .onDisappear{
            if task != nil{
                task = nil
            }
        }
       
    }
    
    private func save(){
        
        let validate = checkFields()
        if !validate.success{
            errorMessage = validate.messageError ?? ""
            showError = true
            return
        }
        
        if let result = task{
            vm.updateTask(id: result.id, task: TaskInput(title: title, description: description))
            dismiss()
        }else{
            vm.createTask(task: TaskInput(title: title, description: description))
            dismiss()
        }
        
        
    }
    
    private func checkFields() -> ResultInput{
        if title.isEmpty{
            return ResultInput(success: false, messageError: "Title is required")
        }
        return ResultInput(success: true)
    }
}

struct CreateUpdateTaskView_Previews: PreviewProvider {
    static var previews: some View {
        CreateUpdateTaskView(task: .constant(Task(TaskListQuery.Data.GetAllTask(id: "", title: ""))))
    }
}
