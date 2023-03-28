//
//  RegisterView.swift
//  TasksGraphQL
//
//  Created by Ariel Ortiz on 3/16/23.
//

import SwiftUI

struct RegisterView: View {
    
    @EnvironmentObject var userViewModel: UserViewModel
    
    @Binding var inLogin: Bool
    
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var passwordConfirm = ""
    
    var body: some View {
        VStack{
            Text("Register")
                .font(.title)
                .padding(.top)
            
            Divider()
            
            
            VStack{
                HStack {
                    Image(systemName: "person.circle.fill")
                        .foregroundColor(.gray)
                        .font(.headline)
                    TextField("Name", text: $name)
                    
                }
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray, lineWidth: 1))
                .padding(.horizontal)
                
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
                
                HStack {
                    Image(systemName: "lock.doc.fill")
                        .foregroundColor(.gray)
                        .font(.headline)
                    SecureField("Confirm Password", text: $passwordConfirm)
                    
                }
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray, lineWidth: 1))
                .padding(.horizontal)
                
            }.padding(.bottom)
            
            
            HStack{
                
                Button(action: {
                    withAnimation {
                        inLogin.toggle()
                    }
                    
                }, label: {
                    Text("Go to Login")
                })
                
                Spacer()
                
                Button(action: {
                    register()
                }, label: {
                    Text("Register")
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
    
    private func register(){
        let input = InputUserRegister(name: name, email: email, password: password, passwordconfirm: passwordConfirm)
 
        userViewModel.validateRegister(input: input)
        
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(inLogin: .constant(false))
    }
}
