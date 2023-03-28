//
//  LoginView.swift
//  TasksGraphQL
//
//  Created by Ariel Ortiz on 3/16/23.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    
    @Binding var inLogin: Bool
    
    @State private var email = ""
    @State private var password = ""
    
    
    var body: some View {
        VStack{
            
            Text("Login")
                .font(.title)
                .padding(.top)
            
            Divider()
            
            
            VStack{
                HStack {
                    Image(systemName: "mail.fill")
                        .foregroundColor(.gray)
                        .font(.headline)
                    TextField("Email", text: $email)
                    
                }
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray, lineWidth: 1))
                .padding(.horizontal)
                
                
                HStack {
                    Image(systemName: "lock.doc.fill")
                        .foregroundColor(.gray)
                        .font(.headline)
                    SecureField("Password", text: $password)            }
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray, lineWidth: 1))
                .padding(.horizontal)
            }
            .padding(.bottom)
            
            
            HStack{
                
                Button(action: {
                    withAnimation {
                        inLogin.toggle()
                    }
                    
                }, label: {
                    Text("Go to Register")
                })
                
                Spacer()
                
                Button(action: {
                    login()
                }, label: {
                    Text("Login")
                        .foregroundColor(.white)
                    
                })
                .padding()
                .background(.blue)
                .clipShape(Capsule())
                
            }.padding(.horizontal)
            
            
            
            Spacer()
            
        }
        .alert(item: $userViewModel.errorMessage){ error in
            Alert(title: Text("Alert"), message: Text(error.msg), dismissButton: .default(Text("OK")))
        }
    }
    
    private func login(){
        let input = InputUserLogin(email: email, password: password)
        
        userViewModel.validateLogin(input: input)
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(inLogin: .constant(false))
    }
}
