//
//  CategoryListPresenter.swift
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

protocol CategoryListPresentationLogic {
    
    // MARK: Present Categories
    func presentCategories(_ response: CategoryList.FetchCategories.Response)
    
    // MARK: Present UpdateCategories
    func presentUpdateCategories(_ response: CategoryList.UpdateCategories.Response)
}

class CategoryListPresenter: CategoryListPresentationLogic {
    weak var viewController: CategoryListDisplayLogic?
    
    // MARK: Present Categories
    func presentCategories(_ response: CategoryList.FetchCategories.Response) {
        if let categories: Array<Category> = response.categories?.toArray(type: Category.self) {
            let viewModel = CategoryList.FetchCategories.ViewModel(categories: categories)
            viewController?.displayCategoriesSuccess(viewModel)
        } else {
            let errorString = "Erro ao carregar categorias!"
            let viewModel = CategoryList.FetchCategories.ViewModel(errorString: errorString)
            viewController?.displayCategoriesError(viewModel)
        }
    }
    
    
    // MARK: Present UpdateCategories
    func presentUpdateCategories(_ response: CategoryList.UpdateCategories.Response) {
        if let error: Error = response.error {
            let errorString = error.localizedDescription
            let viewModel = CategoryList.UpdateCategories.ViewModel(errorString: errorString)
            viewController?.displayUpdateCategoriesError(viewModel)
        } else {
            let viewModel = CategoryList.UpdateCategories.ViewModel(categories: response.categories)
            viewController?.displayUpdateCategoriesSuccess(viewModel)
        }
    }
    
    
}
