//
//  DataProvider.swift
//  Black Star Wear
//
//  Created by Vladislav Len on 13.12.2020.
//

import Foundation
import SwiftyJSON

final class DataProvider {
    
    // MARK: - Types
    
    typealias CategoriesCompletionBlock = ([CategoriesItem]) -> Void
    typealias ProductsCompletionBlock = ([ProductsItem]) -> Void
    typealias DataCompletionBlock = (Data) -> Void
    
    // MARK: - Properties
    
    static let shared = DataProvider()
    
    // MARK: - Public Methods
    
    // Запрашивает список категорий товаров.
    func getCategoriesList(completion: @escaping CategoriesCompletionBlock) {
        let urlString = "https://blackstarshop.ru/?route=api/v1/categories"
        guard let url = URL(string: urlString) else { return }  
        
        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200, error == nil {
                if let categories = self?.parse(categories: data) {
                    completion(categories)
                }
            }
        }
        
        dataTask.resume()
    }
    
    // Запрашивает список товаров.
    func getProductsList(from subcategory: Subcategory, completion: @escaping ProductsCompletionBlock) {
        guard let id = subcategory.id else { return }
        
        let urlString = "https://blackstarshop.ru/?route=api/v1/products&cat_id=\(id)"
        guard let url = URL(string: urlString) else { return }
        
        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200, error == nil {
                if let products = self?.parse(products: data) {
                    completion(products)
                }
            }
        }
        
        dataTask.resume()
    }
    
    // MARK: - Private Methods
    
    // Парсит список категорий товаров.
    private func parse(categories: Data) -> [CategoriesItem]? {
        guard let json = try? JSON(data: categories), let jsonDict = json.dictionaryObject else { return nil }
        var categories = [CategoriesItem]()
        
        for (_, value) in jsonDict {
            if let data = value as? Dictionary<String, Any>, let category = CategoriesItem(data: data) {
                categories.append(category)
            }
        }
        
        return categories
    }
    
    // Парсит список товаров.
    private func parse(products: Data) -> [ProductsItem]? {
        guard let json = try? JSON(data: products), let jsonDict = json.dictionaryObject else { return nil }
        var products = [ProductsItem]()
        
        for (_, value) in jsonDict {
            if let data = value as? Dictionary<String, Any>, let product = ProductsItem(data: data) {
                products.append(product)
            }
        }
        
        return products
    }
    
}
