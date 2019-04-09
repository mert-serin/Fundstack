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
            if searchedItems.count >= 0 && searchedItems.count <= 4{
                searchedResultHeightConstraints.constant = CGFloat(searchedItems.count) * 35
            }else{
                searchedResultHeightConstraints.constant = 4 * 35
            }
            UIView.animate(withDuration: 0.2, delay: 0, options: UIView.AnimationOptions.curveEaseIn, animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
            collectionView.reloadData()
        }
    }
    private var isSearchActive: Bool = false{
        didSet{
            var backgroundColor:UIColor!
            if isSearchActive{
                backgroundColor = UIColor.lightGray
            }else{
                searchedItems = []
                backgroundColor = UIColor.white
            }
            
            UIView.animate(withDuration: 0.3, delay: 0, options: UIView.AnimationOptions.transitionCrossDissolve, animations: {
                self.view.backgroundColor = backgroundColor
            }, completion: nil)
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
