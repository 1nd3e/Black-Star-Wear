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
    
    // MARK: - Methods
    
    // Выполняет сохранение данные в фоновом контексте.
    func save(_ block: @escaping (NSManagedObjectContext) -> Void) {
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
    
}
