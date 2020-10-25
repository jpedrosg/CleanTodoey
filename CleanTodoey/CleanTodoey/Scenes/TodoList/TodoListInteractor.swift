//
//  TodoListInteractor.swift
//  CleanTodoey
//
//  Created by João Pedro Giarrante on 25/10/20.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol TodoListBusinessLogic
{
  func doSomething(request: TodoList.Something.Request)
}

protocol TodoListDataStore
{
  //var name: String { get set }
}

class TodoListInteractor: TodoListBusinessLogic, TodoListDataStore
{
  var presenter: TodoListPresentationLogic?
  var worker: TodoListWorker?
  //var name: String = ""
  
  // MARK: Do something
  
  func doSomething(request: TodoList.Something.Request)
  {
    worker = TodoListWorker()
    worker?.doSomeWork()
    
    let response = TodoList.Something.Response()
    presenter?.presentSomething(response: response)
  }
}
