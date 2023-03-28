//
//  RootAuthenticationView.swift
//  TasksGraphQL
//
//  Created by Ariel Ortiz on 3/16/23.
//

import SwiftUI

struct RootAuthenticationView: View {
        
    @State var inLogin: Bool = true

    var body: some View {
        if inLogin{
            LoginView(inLogin: $inLogin)
        }else{
            RegisterView(inLogin: $inLogin)
        }
    }
}

struct RootAuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        RootAuthenticationView()
    }
}
