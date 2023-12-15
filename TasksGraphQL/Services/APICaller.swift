//
//  APICaller.swift
//  TasksGraphQL
//
//  Created by Ariel Ortiz on 8/9/22.
//

import Foundation
import Apollo

enum ErrorNetwork: Error{
    case badUrl
    case badDecoding
    case badResponse
    case errorLogout
    case serverError(msg: String)
    
    var message: String{
        switch self {
        case .badUrl:
            return "Bad url"
        case .badDecoding:
            return "Bad decoding"
        case .badResponse:
            return "Bad response"
        case .errorLogout:
            return "Bad logout"
        case .serverError(let msg):
            return msg
        }
    }
}

protocol APICallerProtocol{
    func setupApolloClientAuth()
    func register(input: InputUserRegister, completion: @escaping (Result<User, ErrorNetwork>) -> ())
    func getAllTasks(completion: @escaping (Result<[Task], ErrorNetwork>) -> ())
    func login(input: InputUserLogin, completion: @escaping (Result<User, ErrorNetwork>) -> ())
    func logout()
    func createTask(task: TaskInput, completion: @escaping (Bool) -> ())
    func updateTask(id: String, task: TaskInput, completion: @escaping (Bool) -> ())
    func deleteTask(id: String, completion: @escaping (Bool) -> ())
    
}

class APICaller: APICallerProtocol{
    
    static let shared = APICaller()
    
    private(set) var apollo: ApolloClient?
    
    init(){
        setupApolloClient()
    }
    
    public func setupApolloClient(){
        guard let url = URL(string: Constants.url) else{
            return
        }
        self.apollo = ApolloClient(url: url)
    }
    
    public func setupApolloClientAuth(){
        guard let endpointURL = URL(string: Constants.url) else{
            return
        }
        
        var accessToken = ""
        if let token = SecurityManager.shared.get(service: .tokenService, account: .appService){
            accessToken = String(data: token, encoding: .utf8)!
            print(token)
        }
        
        
        let store = ApolloStore()
        let interceptorProvider = NetworkInterceptorsProvider(
            interceptors: [TokenInterceptor(token: accessToken)],
            store: store
        )
        let networkTransport = RequestChainNetworkTransport(
            interceptorProvider: interceptorProvider, endpointURL: endpointURL
        )
        self.apollo = ApolloClient(networkTransport: networkTransport, store: store)
    }
    

    
    public func register(input: InputUserRegister, completion: @escaping (Result<User, ErrorNetwork>) -> ()){
        apollo?.perform(mutation: RegisterUserMutation(name: input.name, email: input.email, password: input.password)){ result in
            switch result{
            case .success(let user):
                
                if user.errors != nil{
                    let errorRes = Utils.processError(error: user.errors!).message
                    completion(.failure(.serverError(msg: errorRes)))
                    return
                }
                
                guard let data = user.data else{
                    
                    completion(.failure(.badDecoding))
                    return
                }
                
                let result = Utils.processDataUserRegister(data: data)
                let dataToken = Data(result.token.utf8)
                SecurityManager.shared.save(dataToken, service: .tokenService, account: .appService)
                self.setupApolloClientAuth()
                completion(.success(result.user))
                
            case .failure(_):
                completion(.failure(.badResponse))
            }

        }
    }
    
    public func login(input: InputUserLogin, completion: @escaping (Result<User, ErrorNetwork>) -> ()){
        apollo?.perform(mutation: LoginMutation(email: input.email, password: input.password)){ result in
            switch result{
            case .success(let user):
                
                if user.errors != nil{
                    let errorRes = Utils.processError(error: user.errors!).message
                    completion(.failure(.serverError(msg: errorRes.description)))
                    return
                }
                
                guard let data = user.data else{
                    
                    completion(.failure(.badDecoding))
                    return
                }
                
                let result = Utils.processDataUserLogin(data: data)
                let dataToken = Data(result.token.utf8)
                SecurityManager.shared.save(dataToken, service: .tokenService, account: .appService)
                self.setupApolloClientAuth()
                completion(.success(result.user))
                
            case .failure(_):
                
                completion(.failure(.badResponse))
            }

        }
    }
    
    public func logout(){
        SecurityManager.shared.delete(service: .tokenService, account: .appService)
        self.setupApolloClient()
    }

    
    
    public func getAllTasks(completion: @escaping (Result<[Task], ErrorNetwork>) -> ()) {
        apollo?.fetch(query: TaskListQuery(), cachePolicy: .fetchIgnoringCacheData){ result in
            switch result{
            case .success(let tasks):
                
                if tasks.errors != nil{
                    let errorRes = Utils.processError(error: tasks.errors!).message
                    completion(.failure(.serverError(msg: errorRes)))
                    return
                }
                
                guard let data = tasks.data else{
                    
                    completion(.failure(.badDecoding))
                    return
                }
                
                guard let result = Utils.processData(data: data) else{
                    completion(.failure(.badDecoding))
                    return
                }
                completion(.success(result))
                
            case .failure(let error):
                
                print(error)
                completion(.failure(.badResponse))
            }
        }
    }
    
    public func createTask(task: TaskInput, completion: @escaping (Bool) -> ()) {
        apollo?.perform(mutation:AddTaskMutation(task: task)){ result in
            switch result{
            case .success(_):
                completion(true)
            case .failure(let error):
                print(error)
                completion(false)
            }
        }
    }
    
    public func updateTask(id: String, task: TaskInput, completion: @escaping (Bool) -> ()) {
        
        apollo?.perform(mutation: UpdateTaskMutation(updateTaskId: id, task: task)){ result in
            switch result{
            case .success(_):
                completion(true)
            case .failure(let error):
                print(error)
                completion(false)
            }
        }
    }
    
    public func deleteTask(id: String, completion: @escaping (Bool) -> ()) {
        apollo?.perform(mutation: DeleteTaskMutation(deleteTaskId: id)){ result in
            switch result{
            case .success(_):
                completion(true)
            case .failure(let error):
                print(error)
                completion(false)
            }
        }
    }
    
    
    
}


class TokenInterceptor: ApolloInterceptor {
    
    let token: String
    
    init(token: String) {
        self.token = token
    }
    
    func interceptAsync<Operation>(
        chain: RequestChain,
        request: HTTPRequest<Operation>,
        response: HTTPResponse<Operation>?,
        completion: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void) where Operation : GraphQLOperation {
            request.addHeader(name: "Authorization", value: "Bearer \(token)")
            chain.proceedAsync(request: request, response: response, completion: completion)
        }
    
}


class NetworkInterceptorsProvider: DefaultInterceptorProvider {
    
    let interceptors: [ApolloInterceptor]
    
    init(interceptors: [ApolloInterceptor], store: ApolloStore) {
        self.interceptors = interceptors
        super.init(store: store)
    }
    
    override func interceptors<Operation>(for operation: Operation) -> [ApolloInterceptor] where Operation : GraphQLOperation {
        var interceptors = super.interceptors(for: operation)
        self.interceptors.forEach { interceptor in
            interceptors.insert(interceptor, at: 0)
        }
        return interceptors
    }
}
