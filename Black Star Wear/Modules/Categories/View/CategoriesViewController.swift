//
//  CategoriesViewController.swift
//  Black Star Wear
//
//  Created by Vladislav Len on 13.12.2020.
//

import UIKit

final class CategoriesViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView!
    
    // MARK: - Properties
    
    var presenter: CategoriesPresenterProtocol?
    
    // MARK: - UIViewController Events
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = presenter as? UITableViewDataSource
        
        presenter?.fetchData()
    }
    
}

// MARK: - CategoriesPresenter Delegate

extension CategoriesViewController: CategoriesViewProtocol {
    
    func tableView(shouldSetUpdates state: Bool) {
        switch state {
        case true:
            tableView.beginUpdates()
        case false:
            tableView.endUpdates()
        }
        
        activityIndicatorView.stopAnimating()
    }
    
    func tableView(shouldInsertRowsAt indexPath: [IndexPath]) {
        tableView.insertRows(at: indexPath, with: .automatic)
    }
    
    func tableView(shouldMoveRowAt indexPath: IndexPath, to newIndexPath: IndexPath) {
        tableView.deleteRows(at: [indexPath], with: .automatic)
        tableView.insertRows(at: [newIndexPath], with: .automatic)
    }
    
    func tableView(shouldReloadRowsAt indexPath: [IndexPath]) {
        tableView.reloadRows(at: indexPath, with: .automatic)
    }
    
    func tableView(shouldDeleteRowsAt indexPath: [IndexPath]) {
        tableView.deleteRows(at: indexPath, with: .automatic)
    }
    
}
