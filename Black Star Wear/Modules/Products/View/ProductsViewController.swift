//
//  ProductsViewController.swift
//  Black Star Wear
//
//  Created by Vladislav Len on 15.12.2020.
//

import UIKit

final class ProductsViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    
    var presenter: ProductsPresenterProtocol?
    
    // MARK: - UIViewController Events
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = presenter as? UICollectionViewDataSource
        collectionView.delegate = presenter as? UICollectionViewDelegate
        
        presenter?.fetchData()
    }
    
}

// MARK: - ProductsPresenter Delegate

extension ProductsViewController: ProductsViewProtocol {
    
    func collectionView(shouldInsertItemsAt indexPath: [IndexPath]) {
        collectionView.performBatchUpdates {
            collectionView.insertItems(at: indexPath)
        }
    }
    
    func collectionView(shouldMoveItemAt indexPath: IndexPath, to newIndexPath: IndexPath) {
        collectionView.performBatchUpdates {
            collectionView.moveItem(at: indexPath, to: newIndexPath)
        }
    }
    
    func collectionView(shouldReloadItemsAt indexPath: [IndexPath]) {
        collectionView.performBatchUpdates {
            collectionView.reloadItems(at: indexPath)
        }
    }
    
    func collectionView(shouldDeleteItemsAt indexPath: [IndexPath]) {
        collectionView.performBatchUpdates {
            collectionView.deleteItems(at: indexPath)
        }
    }
    
}
