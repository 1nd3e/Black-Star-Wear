//
//  SubcategoriesViewController.swift
//  Black Star Wear
//
//  Created by Vladislav Len on 15.12.2020.
//

import UIKit

final class SubcategoriesViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Properties
    
    var presenter: SubcategoriesPresenterProtocol?
    
    // MARK: - UIViewController Events
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = presenter as? UITableViewDataSource
        tableView.delegate = presenter as? UITableViewDelegate
    }
    
}

// MARK: - SubcategoriesPresenter Delegate

extension SubcategoriesViewController: SubcategoriesViewProtocol {
    
    func tableView(shouldSetUpdates state: Bool) {
        switch state {
        case true:
            tableView.beginUpdates()
        case false:
            tableView.endUpdates()
        }
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
