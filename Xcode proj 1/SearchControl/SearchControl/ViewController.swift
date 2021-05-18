//
//  ViewController.swift
//  SearchControl
//
//  Created by Drole on 14/05/21.
//

import UIKit

class ResultVC: UIViewController {
    override func viewDidLayoutSubviews() {
        super.viewDidLoad()
        view.backgroundColor = .blue
    }
}

class ViewController: UIViewController, UISearchResultsUpdating {

    let searchController = UISearchController(searchResultsController: ResultVC() )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
    }
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
       let vc = searchController.searchResultsController as? ResultVC
        vc?.view.backgroundColor = .systemYellow
        print(text)
    }

}

