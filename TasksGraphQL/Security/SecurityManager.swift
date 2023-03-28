//
//  SecurityManager.swift
//  TasksGraphQL
//
//  Created by Ariel Ortiz on 3/17/23.
//

import Foundation
import Security

enum SecurityService: String{
    case tokenService = "token"
    case usernameService = "username"
}

enum SecurityAccount: String{
    case appService = "app"
}

class SecurityManager{
    
    static let shared = SecurityManager()
    
    func save(_ data: Data, service: SecurityService, account: SecurityAccount) {
        // Create query
        let query = [
            kSecValueData: data,
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service.rawValue,
            kSecAttrAccount: account.rawValue,
        ] as CFDictionary
        
        // Add data in query to keychain
        let status = SecItemAdd(query, nil)
        
        if status != errSecSuccess {
            // Print out the error
            print("Error: \(status)")
        }
        
        
        //UPDATE TOKEN
        if status == errSecDuplicateItem {
            // Item already exist, thus update it.
            let query = [
                kSecAttrService: service,
                kSecAttrAccount: account,
                kSecClass: kSecClassGenericPassword,
            ] as CFDictionary
            
            let attributesToUpdate = [kSecValueData: data] as CFDictionary
            
            // Update existing item
            SecItemUpdate(query, attributesToUpdate)
        }
    }
    
    func get(service: SecurityService, account: SecurityAccount) -> Data? {
        
        let query = [
            kSecAttrService: service.rawValue,
            kSecAttrAccount: account.rawValue,
            kSecClass: kSecClassGenericPassword,
            kSecReturnData: true
        ] as CFDictionary
        
        var result: AnyObject?
        SecItemCopyMatching(query, &result)
        
        return (result as? Data)
        
    }
    
    
    func delete(service: SecurityService, account: SecurityAccount) {
        
        let query = [
            kSecAttrService: service.rawValue,
            kSecAttrAccount: account.rawValue,
            kSecClass: kSecClassGenericPassword,
        ] as CFDictionary
        
        // Delete item from keychain
        SecItemDelete(query)
    }
    
}
