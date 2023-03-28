//
//  User.swift
//  TasksGraphQL
//
//  Created by Ariel Ortiz on 3/16/23.
//

import Foundation


struct ErrorMessageServer: Identifiable{
    let id = UUID()
    let msg: String
}

struct ResultInput{
    let success: Bool
    var messageError: String? = nil
}

struct InputUserRegister{
    let name: String
    let email: String
    let password: String
    let passwordconfirm: String
    
    func validate() -> ResultInput{
        
        if name.count < 3{
            return ResultInput(success: false, messageError: "Name needs at least 3 characters")
        }
        
        if !Utils.shared.isValid(email: email){
            return ResultInput(success: false, messageError: "Invalid email")
        }
        
        if password.count < 6{
            return ResultInput(success: false, messageError: "Password needs at least 6 characters")
        }
        
        if passwordconfirm.count < 6{
            return ResultInput(success: false, messageError: "Password needs at least 6 characters")
        }
        
        if password != passwordconfirm{
            return ResultInput(success: false, messageError: "Passwords don't match")
        }
        
        return ResultInput(success: true)
    }
}

struct InputUserLogin{
    let email: String
    let password: String
    
    func validate() -> ResultInput{
        
        if !Utils.shared.isValid(email: email){
            return ResultInput(success: false, messageError: "Invalid email")
        }
        
        if password.count < 6{
            return ResultInput(success: false, messageError: "Password needs at least 6 characters")
        }
        
        return ResultInput(success: true)
    }
}

struct User: Decodable{
    let id: String
    let name: String
    
}

struct AuthResponse: Decodable{
    let token: String
    let user: User
}
