//
//  ProductsPresenter.swift
//  Black Star Wear
//
//  Created by Vladislav Len on 15.12.2020.
//

import UIKit
import CoreData

protocol ProductsViewProtocol: class {
    func collectionView(shouldInsertItemsAt indexPath: [IndexPath])
    func collectionView(shouldMoveItemAt indexPath: IndexPath, to newIndexPath: IndexPath)
    func collectionView(shouldReloadItemsAt indexPath: [IndexPath])
    func collectionView(shouldDeleteItemsAt indexPath: [IndexPath])
}

protocol ProductsPresenterProtocol {
    init(model: Subcategory, view: ProductsViewProtocol, router: ProductsRouterProtocol)
    func fetchData()
}

final class ProductsPresenter: NSObject, ProductsPresenterProtocol {
    
    // MARK: - Properties
    
    private let model: Subcategory
    private weak var view: ProductsViewProtocol?
    private let router: ProductsRouterProtocol
    
    private lazy var fetchedResultsController: NSFetchedResultsController<Product> = {
        let context = Database.shared.viewContext
        
        let predicate = NSPredicate(format: "subcategory == %@", model)
        let sortBySortOrder = NSSortDescriptor(key: "sortOrder", ascending: true)
        let sortByName = NSSortDescriptor(key: "name", ascending: true)
        
        let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
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
    
    init(model: Subcategory, view: ProductsViewProtocol, router: ProductsRouterProtocol) {
        self.model = model
        self.view = view
        self.router = router
    }
    
    // MARK: - Methods
    
    // Запрашивает список товаров для презентации.
    func fetchData() {
        let relationship = model
        
        DataProvider.shared.getProductsList(from: model) { products in
            Database.shared.write(data: products, relationship: relationship)
        }
    }
    
}

// MARK: - UICollectionView Data Source

extension ProductsPresenter: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let products = fetchedResultsController.fetchedObjects {
            return products.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductsCell", for: indexPath) as? ProductsCollectionViewCell else { return UICollectionViewCell() }
        
        let product = fetchedResultsController.object(at: indexPath)
        cell.configure(with: product)
        
        return cell
    }
    
}

// MARK: - UICollectionView Delegate

extension ProductsPresenter: UICollectionViewDelegate {
    
    // Отменяет незавершенную загрузку изображения при исчезновении ячейки.
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? ProductsCollectionViewCell else { return }
        cell.thumbImageView.kf.cancelDownloadTask()
    }
    
}

// MARK: - NSFetchedResultsController Delegate

extension ProductsPresenter: NSFetchedResultsControllerDelegate {
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let newIndexPath = newIndexPath {
                view?.collectionView(shouldInsertItemsAt: [newIndexPath])
            }
        case .move:
            if let indexPath = indexPath, let newIndexPath = newIndexPath {
                view?.collectionView(shouldMoveItemAt: indexPath, to: newIndexPath)
            }
        case .update:
            if let indexPath = indexPath {
                view?.collectionView(shouldReloadItemsAt: [indexPath])
            }
        case .delete:
            if let indexPath = indexPath {
                view?.collectionView(shouldDeleteItemsAt: [indexPath])
            }
        default:
            break
        }
    }
    
}
