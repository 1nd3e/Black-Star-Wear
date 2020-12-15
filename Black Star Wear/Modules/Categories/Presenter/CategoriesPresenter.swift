//
//  CategoriesPresenter.swift
//  Black Star Wear
//
//  Created by Vladislav Len on 13.12.2020.
//

import UIKit
import CoreData

protocol CategoriesViewProtocol: class {
    func tableView(shouldSetUpdates state: Bool)
    func tableView(shouldInsertRowsAt indexPath: [IndexPath])
    func tableView(shouldMoveRowAt indexPath: IndexPath, to newIndexPath: IndexPath)
    func tableView(shouldReloadRowsAt indexPath: [IndexPath])
    func tableView(shouldDeleteRowsAt indexPath: [IndexPath])
}

protocol CategoriesPresenterProtocol {
    init(view: CategoriesViewProtocol, router: CategoriesRouterProtocol)
    func fetchData()
}

final class CategoriesPresenter: NSObject, CategoriesPresenterProtocol {
    
    // MARK: - Properties
    
    private weak var view: CategoriesViewProtocol?
    private let router: CategoriesRouterProtocol
    
    private lazy var fetchedResultsController: NSFetchedResultsController<Category> = {
        let context = Database.shared.viewContext
        
        let sortBySortOrder = NSSortDescriptor(key: "sortOrder", ascending: true)
        let sortByName = NSSortDescriptor(key: "name", ascending: true)
        
        let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
        fetchRequest.sortDescriptors = [sortBySortOrder, sortByName]
        fetchRequest.fetchBatchSize = 24
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
        } catch let error {
            print("Unable to fetch data: \(error.localizedDescription)")
        }
        
        return fetchedResultsController
    }()
    
    // MARK: - Initializers
    
    init(view: CategoriesViewProtocol, router: CategoriesRouterProtocol) {
        self.view = view
        self.router = router
    }
    
    // MARK: - Public Methods
    
    // Запрашивает список категорий для презентации.
    func fetchData() {
        DataProvider.shared.getCategoriesList { [weak self] categories in
            self?.saveData(categories)
        }
    }
    
    // MARK: - Private Methods
    
    // Сохраняет в базу данных список категорий и подкатегорий.
    private func saveData(_ data: [CategoriesItem]) {
        data.forEach { model in
            Database.shared.save { context in
                let category = Category(model: model, context: context)
                
                let subcategories = model.subcategories
                subcategories.forEach { data in
                    guard let subcategoriesItem = SubcategoriesItem(data: data) else { return }
                    let subcategory = Subcategory(model: subcategoriesItem, context: context)
                    
                    category.addToSubcategories(subcategory)
                }
            }
        }
    }
    
}

// MARK: - UITableView Data Source

extension CategoriesPresenter: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let categories = fetchedResultsController.fetchedObjects {
            return categories.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CategoriesCell") as? CategoriesTableViewCell else { return UITableViewCell() }
        
        let category = fetchedResultsController.object(at: indexPath)
        cell.titleLabel.text = category.name
        
        return cell
    }
    
}

// MARK: - NSFetchedResultsController Delegate

extension CategoriesPresenter: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        view?.tableView(shouldSetUpdates: true)
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let newIndexPath = newIndexPath {
                view?.tableView(shouldInsertRowsAt: [newIndexPath])
            }
        case .move:
            if let indexPath = indexPath, let newIndexPath = newIndexPath {
                view?.tableView(shouldMoveRowAt: indexPath, to: newIndexPath)
            }
        case .update:
            if let indexPath = indexPath {
                view?.tableView(shouldReloadRowsAt: [indexPath])
            }
        case .delete:
            if let indexPath = indexPath {
                view?.tableView(shouldDeleteRowsAt: [indexPath])
            }
        default:
            break
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        view?.tableView(shouldSetUpdates: false)
    }
    
}
