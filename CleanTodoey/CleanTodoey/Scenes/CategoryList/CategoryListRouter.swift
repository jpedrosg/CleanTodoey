//
//  CategoryListRouter.swift
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

@objc protocol CategoryListRoutingLogic
{
  func routeToTodoList(segue: UIStoryboardSegue?)
}

protocol CategoryListDataPassing
{
  var dataStore: CategoryListDataStore? { get }
}

class CategoryListRouter: NSObject, CategoryListRoutingLogic, CategoryListDataPassing
{
  weak var viewController: CategoryListViewController?
  var dataStore: CategoryListDataStore?
  
  // MARK: Routing
  
  func routeToTodoList(segue: UIStoryboardSegue?) {
    if let segue = segue {
      let destinationVC = segue.destination as! TodoListViewController
      var destinationDS = destinationVC.router!.dataStore!
      passDataToTodoList(source: dataStore!, destination: &destinationDS)
    } else {
      let storyboard = UIStoryboard(name: "Main", bundle: nil)
      let destinationVC = storyboard.instantiateViewController(withIdentifier: "TodoListViewController") as! TodoListViewController
      var destinationDS = destinationVC.router!.dataStore!
      passDataToTodoList(source: dataStore!, destination: &destinationDS)
      navigateToTodoList(source: viewController!, destination: destinationVC)
    }
  }

  // MARK: Navigation
  
  func navigateToTodoList(source: CategoryListViewController, destination: TodoListViewController) {
    source.show(destination, sender: nil)
  }
  
  // MARK: Passing data
  
  func passDataToTodoList(source: CategoryListDataStore, destination: inout TodoListDataStore) {
    if let selectedItem = source.selectedItem {
        destination.selectedCategory = selectedItem
    }
  }
}
