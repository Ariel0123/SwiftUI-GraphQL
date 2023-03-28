//
//  TasksGraphQLApp.swift
//  TasksGraphQL
//
//  Created by Ariel Ortiz on 8/9/22.
//

import SwiftUI

@main
struct TasksGraphQLApp: App {
    
    @StateObject var vm = UserViewModel()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(vm)
        }
    }
}
