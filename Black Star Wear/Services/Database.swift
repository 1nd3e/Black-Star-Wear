//
//  Database.swift
//  Black Star Wear
//
//  Created by Vladislav Len on 14.12.2020.
//

import CoreData

final class Database {
    
    // MARK: - Properties
    
    static let shared = Database()
    
    // MARK: - Core Data Stack
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Data")
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Unable to load Persistent Stores: \(error.localizedDescription)")
            }
        }
        
        return container
    }()
    
    private lazy var backgroundContext: NSManagedObjectContext = {
        let context = persistentContainer.newBackgroundContext()
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        return context
    }()
    
    private(set) lazy var viewContext: NSManagedObjectContext = {
        let context = persistentContainer.viewContext
        context.automaticallyMergesChangesFromParent = true
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        return context
    }()
    
    // MARK: - Public Methods
    
    // Сохраняет список категорий и подкатегорий в базу данных.
    func write(data categories: [CategoriesItem]) {
        categories.forEach { model in
            save { context in
                let category = Category(model: model, context: context)
                
                let subcategories = model.subcategories
                subcategories.forEach { data in
                    guard let model = SubcategoriesItem(data: data) else { return }
                    let subcategory = Subcategory(model: model, context: context)
                    
                    category.addToSubcategories(subcategory)
                }
            }
        }
    }
    
    // Сохраняет список товаров в базу данных.
    func write(data products: [ProductsItem], relationship subcategory: Subcategory) {
        guard let id = subcategory.id else { return }
        
        products.forEach { model in
            save { [weak self] context in
                if let subcategory = self?.fetchObject(withIdentifier: id, type: Subcategory.self, in: context) {
                    let product = Product(model: model, context: context)
                    subcategory.addToProducts(product)
                }
            }
        }
    }
    
    // MARK: - Private Methods
    
    // Выполняет сохранение данные в фоновом контексте.
    private func save(_ block: @escaping (NSManagedObjectContext) -> Void) {
        let context = backgroundContext
        
        context.perform {
            block(context)
            
            if context.hasChanges {
                do {
                    try context.save()
                } catch let error {
                    print("Unable to save context: \(error.localizedDescription)")
                }
            }
        }
    }
    
    // Достаёт объект из базы данных.
    private func fetchObject<T: NSManagedObject>(withIdentifier id: String, type: T.Type, in context: NSManagedObjectContext) -> T? {
        var object: T?
        
        let fetchRequest = NSFetchRequest<T>(entityName: String(describing: T.self))
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        
        do {
            object = try context.fetch(fetchRequest).first
        } catch let error {
            print("Unable to fetch object: \(error.localizedDescription)")
        }
        
        return object
    }
    
}
