//
//  CategoryListInteractor.swift
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

protocol CategoryListBusinessLogic {
    
    // MARK: Fetch Categories
    func fetchCategories()
    
    // MARK: Update Categories
    func updateCategories(with request: CategoryListModel.UpdateCategories.Request)
    
    // MARK: DidSelect Row
    func didSelectRow(index: Int)
}

protocol CategoryListDataStore {
    var selectedItem: Category? { get set }
}

class CategoryListInteractor: CategoryListBusinessLogic, CategoryListDataStore {

    // MARK: Properties
    var selectedItem: Category?
    var categories: Array<Category>?
    var presenter: CategoryListPresentationLogic?
    var worker: CategoryListWorker?
    
    
    // MARK: Fetch Categories
    
    func fetchCategories() {
        worker = CategoryListWorker()
        worker?.fetchCategories()
            .done(handleFetchCategories)
    }
    
    private func handleFetchCategories(response: CategoryListModel.FetchCategories.Response){
        if let categories: Array<Category> = response.categories?.toArray(type: Category.self) {
            self.categories = categories
        }
        presenter?.presentCategories(response)
    }
    
    
    // MARK: Update Categories
    
    func updateCategories(with request: CategoryListModel.UpdateCategories.Request) {
        worker = CategoryListWorker()
        worker?.updateCategories(with: request)
            .done(handleUpdateCategoriesSuccess)
            .catch(handleUpdateCategoriesError)
    }
    
    private func handleUpdateCategoriesSuccess(response: CategoryListModel.UpdateCategories.Response){
        if let category = response.addedCategory {
            categories?.append(category)
        } else if let category = response.removedCategory, let correctIndex = categories?.firstIndex(of: category) {
            categories?.remove(at: correctIndex)
        }
        let finalResponse = CategoryListModel.UpdateCategories.Response(categories:self.categories, error: response.error)
        presenter?.presentUpdateCategories(finalResponse)
    }
    
    private func handleUpdateCategoriesError(error: Error){
        let response = CategoryListModel.UpdateCategories.Response(error: error)
        presenter?.presentUpdateCategories(response)
    }
    
    
    // MARK: DidSelect Row
    
    func didSelectRow(index: Int) {
        guard let item = categories?[index] else { return }
        selectedItem = item
        presenter?.presentTodoList()
    }
}
