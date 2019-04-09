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
