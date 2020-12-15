//
//  SubcategoriesPresenter.swift
//  Black Star Wear
//
//  Created by Vladislav Len on 15.12.2020.
//

import UIKit
import CoreData

protocol SubcategoriesViewProtocol: class {
    func tableView(shouldSetUpdates state: Bool)
    func tableView(shouldInsertRowsAt indexPath: [IndexPath])
    func tableView(shouldMoveRowAt indexPath: IndexPath, to newIndexPath: IndexPath)
    func tableView(shouldReloadRowsAt indexPath: [IndexPath])
    func tableView(shouldDeleteRowsAt indexPath: [IndexPath])
}

protocol SubcategoriesPresenterProtocol {
    init(view: SubcategoriesViewProtocol, router: SubcategoriesRouterProtocol, category: Category)
}

final class SubcategoriesPresenter: NSObject, SubcategoriesPresenterProtocol {
    
    // MARK: - Properties
    
    private weak var view: SubcategoriesViewProtocol?
    private let router: SubcategoriesRouterProtocol
    private let category: Category
    
    private lazy var fetchedResultsController: NSFetchedResultsController<Subcategory> = {
        let context = Database.shared.viewContext
        
        let predicate = NSPredicate(format: "category == %@", category)
        let sortBySortOrder = NSSortDescriptor(key: "sortOrder", ascending: true)
        let sortByName = NSSortDescriptor(key: "name", ascending: true)
        
        let fetchRequest: NSFetchRequest<Subcategory> = Subcategory.fetchRequest()
        fetchRequest.predicate = predicate
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
    
    init(view: SubcategoriesViewProtocol, router: SubcategoriesRouterProtocol, category: Category) {
        self.view = view
        self.router = router
        self.category = category
    }
    
}

// MARK: - UITableView Data Source

extension SubcategoriesPresenter: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let subcategories = fetchedResultsController.fetchedObjects {
            return subcategories.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SubcategoriesCell") as? SubcategoriesTableViewCell else { return UITableViewCell() }
        
        let subcategory = fetchedResultsController.object(at: indexPath)
        cell.configure(with: subcategory)
        
        return cell
    }
    
}

// MARK: - UITableView Delegate

extension SubcategoriesPresenter: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

// MARK: - NSFetchedResultsController Delegate

extension SubcategoriesPresenter: NSFetchedResultsControllerDelegate {
    
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
