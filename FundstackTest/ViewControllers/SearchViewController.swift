//
//  SearchViewController.swift
//  FundstackTest
//
//  Created by Mert Serin on 9.04.2019.
//  Copyright © 2019 Mert Serin. All rights reserved.
//

import UIKit
import CoreData

class SearchViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: Private Variables
    private var searchController: SearchControllerProtocol!
    private var searchedResultCellIdentifier = "SearchedResultCell"
    private var searchedItems: [SearchResult] = []{
        didSet{
            collectionView.reloadData()
        }
    }
    
    //MARK: Constraints
    
    @IBOutlet weak var searchedResultHeightConstraints: NSLayoutConstraint!
    
    //MARK: Segues
    private var searchResultDetailSegue = "SearchResultDetailSegue"
    
    //MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == searchResultDetailSegue{
            if let searchResultDetailViewController = segue.destination as? SearchResultDetailViewController,
                let searchResult = sender as? SearchResult {
                searchResultDetailViewController.searchedResult = searchResult
            }
        }
    }
    
    

    @IBAction func textFieldEditingChanged(_ sender: UITextField) {
        guard let searchedText = sender.text, searchedText != "" else{
            return
        }
        
        searchController.fetchItems(for: searchedText) { (isSuccess, result, error) in
            if isSuccess{
                self.searchedItems = result ?? []
            }else{
                
            }
        }
    }
    
    public static func create(persistentContainer: NSPersistentContainer) -> SearchViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let searchViewController = storyboard.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        searchViewController.searchController = SearchController(persistentContainer: persistentContainer)
        return searchViewController
    }

}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: searchedResultCellIdentifier, for: indexPath) as! SearchedResultCell
        let model = searchedItems[indexPath.row]
        cell.searchedResult = model
        cell.onElementSelected = { (model) -> Void in
            self.performSegue(withIdentifier: self.searchResultDetailSegue, sender: model)
        }
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchedItems.count
    }
}
