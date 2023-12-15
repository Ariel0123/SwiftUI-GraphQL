//
//  UserViewModel.swift
//  TasksGraphQL
//
//  Created by Ariel Ortiz on 3/16/23.
//

import Foundation
import SwiftUI

class UserViewModel: ObservableObject{
    
    @Published var userName: String?
    @Published var isAuth: Bool = false
    @Published var errorMessage: ErrorMessageServer?
    
    private var apiCaller: APICallerProtocol
    
    init(apiCaller: APICallerProtocol = APICaller.shared){
        self.apiCaller = apiCaller
    }
    
    public func getUser(){
        if let data = SecurityManager.shared.get(service: .usernameService, account: .appService){
            self.userName = String(data: data, encoding: .utf8)!
        }
    }

    public func getAuth(){
        if let _ = SecurityManager.shared.get(service: .tokenService, account: .appService){
            apiCaller.setupApolloClientAuth()
            self.isAuth = true
        }else{
            self.isAuth = false
        }

    }
    
    public func register(input: InputUserRegister){
        apiCaller.register(input: input){ [weak self] result in
            switch result {
            case .success(let user):
                withAnimation {
                    self?.isAuth = true
                }
                
                self?.userName = user.name
                let data = Data(user.name.utf8)
                SecurityManager.shared.save(data, service: .usernameService, account: .appService)
            case .failure(let failure):
                self?.errorMessage = ErrorMessageServer(msg: failure.message)
            }
        }
    }
    
    public func login(input: InputUserLogin){
        apiCaller.login(input: input) { [weak self] result in
            switch result {
            case .success(let user):
                withAnimation {
                    self?.isAuth = true
                }
                self?.userName = user.name
                let data = Data(user.name.utf8)
                SecurityManager.shared.save(data, service: .usernameService, account: .appService)
            case .failure(let failure):
                self?.errorMessage = ErrorMessageServer(msg: failure.message)
            }
        }
    }
    
    public func logout(){
        apiCaller.logout()
        withAnimation {
            self.isAuth = false
        }
        self.userName = nil
        SecurityManager.shared.delete(service: .usernameService, account: .appService)
    }
    
    
    public func validateLogin(input: InputUserLogin){
        let validateResult = input.validate()
        if !validateResult.success{
            self.errorMessage = ErrorMessageServer(msg: validateResult.messageError ?? "")
        }else{
            self.login(input: input)
        }
    }
    
    public func validateRegister(input: InputUserRegister){
        let validateResult = input.validate()
        if !validateResult.success{
            self.errorMessage = ErrorMessageServer(msg: validateResult.messageError ?? "")
        }else{
            self.register(input: input)
        }
    }
}
