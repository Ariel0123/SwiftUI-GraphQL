//
//  ContentView.swift
//  TasksGraphQL
//
//  Created by Ariel Ortiz on 8/9/22.
//

import SwiftUI

struct RootView: View {
    
    @EnvironmentObject var vm: UserViewModel
        
    var body: some View {
        VStack(spacing: 0){
            if vm.isAuth{
                HomeView()
            }else{
                RootAuthenticationView()
            }
        }.onAppear{
            vm.getAuth()
            vm.getUser()
        }
        
    }
        
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
