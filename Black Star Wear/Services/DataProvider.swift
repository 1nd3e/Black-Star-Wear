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
    
    // Загружает изображение по ссылке.
    // Если изображение лежит в кэше, то отдаём его без осуществления сетевого запроса,
    // в противном случае выполняем новую загрузку изображения.
    func loadImage(from imagePath: String, completion: @escaping DataCompletionBlock) {
        let urlString = "https://blackstarshop.ru/\(imagePath)"
        guard let url = URL(string: urlString) else { return }
        
        let cache = URLCache.shared
        let request = URLRequest(url: url)
        
        DispatchQueue.global(qos: .background).async {
            if let cachedResponse = cache.cachedResponse(for: request) {
                let data = cachedResponse.data
                
                DispatchQueue.main.async {
                    completion(data)
                }
            } else {
                let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
                    if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200, error == nil {
                        let cachedData = CachedURLResponse(response: response, data: data)
                        cache.storeCachedResponse(cachedData, for: request)
                        
                        DispatchQueue.main.async {
                            completion(data)
                        }
                    }
                }
                
                dataTask.resume()
            }
        }
    }
    
    // MARK: - Private Methods
    
    // Парсит данные с категориями товаров и приводит их в нужный вид.
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
    
}
