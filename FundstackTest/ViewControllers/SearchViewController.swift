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
    
    //MARK: Private Variables
    private var searchController: SearchControllerProtocol!
    private var searchedResultCellIdentifier = "SearchedResultCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    @IBAction func textFieldEditingChanged(_ sender: UITextField) {
        guard let searchedText = sender.text, searchedText != "" else{
            return
        }
        
        searchController.fetchItems(for: searchedText) { (isSuccess, result, error) in
            if isSuccess{
                print(result)
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: searchedResultCellIdentifier, for: indexPath)
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
}
