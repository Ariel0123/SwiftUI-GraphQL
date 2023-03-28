// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public struct TaskInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - title
  ///   - description
  public init(title: Swift.Optional<String?> = nil, description: Swift.Optional<String?> = nil) {
    graphQLMap = ["title": title, "description": description]
  }

  public var title: Swift.Optional<String?> {
    get {
      return graphQLMap["title"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "title")
    }
  }

  public var description: Swift.Optional<String?> {
    get {
      return graphQLMap["description"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "description")
    }
  }
}

public final class TaskListQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query TaskList {
      getAllTasks {
        __typename
        id
        title
        description
      }
    }
    """

  public let operationName: String = "TaskList"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("getAllTasks", type: .list(.object(GetAllTask.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(getAllTasks: [GetAllTask?]? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "getAllTasks": getAllTasks.flatMap { (value: [GetAllTask?]) -> [ResultMap?] in value.map { (value: GetAllTask?) -> ResultMap? in value.flatMap { (value: GetAllTask) -> ResultMap in value.resultMap } } }])
    }

    public var getAllTasks: [GetAllTask?]? {
      get {
        return (resultMap["getAllTasks"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [GetAllTask?] in value.map { (value: ResultMap?) -> GetAllTask? in value.flatMap { (value: ResultMap) -> GetAllTask in GetAllTask(unsafeResultMap: value) } } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [GetAllTask?]) -> [ResultMap?] in value.map { (value: GetAllTask?) -> ResultMap? in value.flatMap { (value: GetAllTask) -> ResultMap in value.resultMap } } }, forKey: "getAllTasks")
      }
    }

    public struct GetAllTask: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Task"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("title", type: .nonNull(.scalar(String.self))),
          GraphQLField("description", type: .scalar(String.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID, title: String, description: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "Task", "id": id, "title": title, "description": description])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return resultMap["id"]! as! GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var title: String {
        get {
          return resultMap["title"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "title")
        }
      }

      public var description: String? {
        get {
          return resultMap["description"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "description")
        }
      }
    }
  }
}

public final class SingleTaskQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query SingleTask($getTaskId: ID) {
      getTask(id: $getTaskId) {
        __typename
        id
        title
        description
      }
    }
    """

  public let operationName: String = "SingleTask"

  public var getTaskId: GraphQLID?

  public init(getTaskId: GraphQLID? = nil) {
    self.getTaskId = getTaskId
  }

  public var variables: GraphQLMap? {
    return ["getTaskId": getTaskId]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("getTask", arguments: ["id": GraphQLVariable("getTaskId")], type: .object(GetTask.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(getTask: GetTask? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "getTask": getTask.flatMap { (value: GetTask) -> ResultMap in value.resultMap }])
    }

    public var getTask: GetTask? {
      get {
        return (resultMap["getTask"] as? ResultMap).flatMap { GetTask(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "getTask")
      }
    }

    public struct GetTask: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Task"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("title", type: .nonNull(.scalar(String.self))),
          GraphQLField("description", type: .scalar(String.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID, title: String, description: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "Task", "id": id, "title": title, "description": description])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return resultMap["id"]! as! GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var title: String {
        get {
          return resultMap["title"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "title")
        }
      }

      public var description: String? {
        get {
          return resultMap["description"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "description")
        }
      }
    }
  }
}

public final class RegisterUserMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation RegisterUser($name: String!, $email: String!, $password: String!) {
      registerUser(name: $name, email: $email, password: $password) {
        __typename
        user {
          __typename
          id
          name
        }
        token
      }
    }
    """

  public let operationName: String = "RegisterUser"

  public var name: String
  public var email: String
  public var password: String

  public init(name: String, email: String, password: String) {
    self.name = name
    self.email = email
    self.password = password
  }

  public var variables: GraphQLMap? {
    return ["name": name, "email": email, "password": password]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("registerUser", arguments: ["name": GraphQLVariable("name"), "email": GraphQLVariable("email"), "password": GraphQLVariable("password")], type: .nonNull(.object(RegisterUser.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(registerUser: RegisterUser) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "registerUser": registerUser.resultMap])
    }

    public var registerUser: RegisterUser {
      get {
        return RegisterUser(unsafeResultMap: resultMap["registerUser"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "registerUser")
      }
    }

    public struct RegisterUser: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["AuthPayload"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("user", type: .nonNull(.object(User.selections))),
          GraphQLField("token", type: .nonNull(.scalar(String.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(user: User, token: String) {
        self.init(unsafeResultMap: ["__typename": "AuthPayload", "user": user.resultMap, "token": token])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var user: User {
        get {
          return User(unsafeResultMap: resultMap["user"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "user")
        }
      }

      public var token: String {
        get {
          return resultMap["token"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "token")
        }
      }

      public struct User: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["User"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
            GraphQLField("name", type: .nonNull(.scalar(String.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: GraphQLID, name: String) {
          self.init(unsafeResultMap: ["__typename": "User", "id": id, "name": name])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: GraphQLID {
          get {
            return resultMap["id"]! as! GraphQLID
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var name: String {
          get {
            return resultMap["name"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "name")
          }
        }
      }
    }
  }
}

public final class LoginMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation Login($email: String!, $password: String!) {
      login(email: $email, password: $password) {
        __typename
        user {
          __typename
          id
          name
        }
        token
      }
    }
    """

  public let operationName: String = "Login"

  public var email: String
  public var password: String

  public init(email: String, password: String) {
    self.email = email
    self.password = password
  }

  public var variables: GraphQLMap? {
    return ["email": email, "password": password]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("login", arguments: ["email": GraphQLVariable("email"), "password": GraphQLVariable("password")], type: .nonNull(.object(Login.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(login: Login) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "login": login.resultMap])
    }

    public var login: Login {
      get {
        return Login(unsafeResultMap: resultMap["login"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "login")
      }
    }

    public struct Login: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["AuthPayload"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("user", type: .nonNull(.object(User.selections))),
          GraphQLField("token", type: .nonNull(.scalar(String.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(user: User, token: String) {
        self.init(unsafeResultMap: ["__typename": "AuthPayload", "user": user.resultMap, "token": token])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var user: User {
        get {
          return User(unsafeResultMap: resultMap["user"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "user")
        }
      }

      public var token: String {
        get {
          return resultMap["token"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "token")
        }
      }

      public struct User: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["User"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
            GraphQLField("name", type: .nonNull(.scalar(String.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: GraphQLID, name: String) {
          self.init(unsafeResultMap: ["__typename": "User", "id": id, "name": name])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: GraphQLID {
          get {
            return resultMap["id"]! as! GraphQLID
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var name: String {
          get {
            return resultMap["name"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "name")
          }
        }
      }
    }
  }
}

public final class AddTaskMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation AddTask($task: TaskInput!) {
      createTask(task: $task) {
        __typename
        title
      }
    }
    """

  public let operationName: String = "AddTask"

  public var task: TaskInput

  public init(task: TaskInput) {
    self.task = task
  }

  public var variables: GraphQLMap? {
    return ["task": task]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("createTask", arguments: ["task": GraphQLVariable("task")], type: .object(CreateTask.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(createTask: CreateTask? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "createTask": createTask.flatMap { (value: CreateTask) -> ResultMap in value.resultMap }])
    }

    public var createTask: CreateTask? {
      get {
        return (resultMap["createTask"] as? ResultMap).flatMap { CreateTask(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "createTask")
      }
    }

    public struct CreateTask: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Task"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("title", type: .nonNull(.scalar(String.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(title: String) {
        self.init(unsafeResultMap: ["__typename": "Task", "title": title])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var title: String {
        get {
          return resultMap["title"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "title")
        }
      }
    }
  }
}

public final class UpdateTaskMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation UpdateTask($updateTaskId: ID!, $task: TaskInput!) {
      updateTask(id: $updateTaskId, task: $task) {
        __typename
        title
      }
    }
    """

  public let operationName: String = "UpdateTask"

  public var updateTaskId: GraphQLID
  public var task: TaskInput

  public init(updateTaskId: GraphQLID, task: TaskInput) {
    self.updateTaskId = updateTaskId
    self.task = task
  }

  public var variables: GraphQLMap? {
    return ["updateTaskId": updateTaskId, "task": task]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("updateTask", arguments: ["id": GraphQLVariable("updateTaskId"), "task": GraphQLVariable("task")], type: .object(UpdateTask.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(updateTask: UpdateTask? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "updateTask": updateTask.flatMap { (value: UpdateTask) -> ResultMap in value.resultMap }])
    }

    public var updateTask: UpdateTask? {
      get {
        return (resultMap["updateTask"] as? ResultMap).flatMap { UpdateTask(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "updateTask")
      }
    }

    public struct UpdateTask: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Task"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("title", type: .nonNull(.scalar(String.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(title: String) {
        self.init(unsafeResultMap: ["__typename": "Task", "title": title])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var title: String {
        get {
          return resultMap["title"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "title")
        }
      }
    }
  }
}

public final class DeleteTaskMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation DeleteTask($deleteTaskId: ID!) {
      deleteTask(id: $deleteTaskId)
    }
    """

  public let operationName: String = "DeleteTask"

  public var deleteTaskId: GraphQLID

  public init(deleteTaskId: GraphQLID) {
    self.deleteTaskId = deleteTaskId
  }

  public var variables: GraphQLMap? {
    return ["deleteTaskId": deleteTaskId]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("deleteTask", arguments: ["id": GraphQLVariable("deleteTaskId")], type: .scalar(String.self)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(deleteTask: String? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "deleteTask": deleteTask])
    }

    public var deleteTask: String? {
      get {
        return resultMap["deleteTask"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "deleteTask")
      }
    }
  }
}
