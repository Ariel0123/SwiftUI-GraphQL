//
//  Utils.swift
//  TasksGraphQL
//
//  Created by Ariel Ortiz on 3/13/23.
//

import Foundation
import Apollo

class Utils{
        
    static func processData(data: TaskListQuery.Data) -> [Task]?{
        guard let list = data.getAllTasks else{ return nil }
        let results = list.map({Task($0)})
        return results
    }
    
    static func processDataUserRegister(data: RegisterUserMutation.Data) -> AuthResponse{
        let user = data.registerUser
        return AuthResponse(token: user.token, user: User(id: user.user.id, name: user.user.name))
    }
    
    static func processDataUserLogin(data: LoginMutation.Data) -> AuthResponse{
        let user = data.login
        return AuthResponse(token: user.token, user: User(id: user.user.id, name: user.user.name))
    }
    
    static func processError(error: [GraphQLError]) -> MessageError{
        let message = error.first
        return MessageError(message: message!.message!)
    }
    
    static func isValid(email: String) -> Bool
    {
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        let regex = try! NSRegularExpression(pattern: emailRegEx)
        let nsRange = NSRange(location: 0, length: email.count)
        let results = regex.matches(in: email, range: nsRange)
        if results.count == 0
        {
            return false
        }
        return true
    }
}
