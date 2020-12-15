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
    
    // MARK: - Methods
    
    // Запрашивает список категорий для презентации.
    func fetchData() {
        DataProvider.shared.getCategoriesList { categories in
            Database.shared.write(data: categories)
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
        cell.configure(with: category)
        
        return cell
    }
    
}

// MARK: - UITableView Delegate

extension CategoriesPresenter: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCategory = fetchedResultsController.object(at: indexPath)
        router.moveToSubcategories(category: selectedCategory)
        
        tableView.deselectRow(at: indexPath, animated: true)
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
