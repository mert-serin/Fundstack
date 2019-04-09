//
//  SearchController.swift
//  FundstackTest
//
//  Created by Mert Serin on 9.04.2019.
//  Copyright © 2019 Mert Serin. All rights reserved.
//

import Foundation
import CoreData

typealias FetchSearchResultCompletionBlock = (_ success: Bool, _ result: [SearchResult]?, _ error: NSError?) -> Void

protocol SearchControllerProtocol {
    func fetchItems(for query: String, _ completionBlock: @escaping FetchSearchResultCompletionBlock)
}

extension SearchControllerProtocol {
    func fetchItems(for query: String, _ completionBlock: @escaping FetchSearchResultCompletionBlock) {}
}


class SearchController: SearchControllerProtocol {
    private static let entityName = "SearchResult"
    
    private let persistentContainer: NSPersistentContainer
    
    init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
    }
    
    func fetchItems(for query: String, _ completionBlock: @escaping FetchSearchResultCompletionBlock) {
        fetchFromStorageOrAPI(for: query, completion: completionBlock)
    }
}

private extension SearchController {
    
    func parse(for query:String, _ jsonData: Data) -> (results: [SearchResult]?, isSuccess: Bool) {
        do {
            guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext else {
                fatalError("Failed to retrieve managed object conte xt")
            }
            // Parse JSON data
            let managedObjectContext = persistentContainer.viewContext
            let decoder = JSONDecoder()
            decoder.userInfo[codingUserInfoKeyManagedObjectContext] = managedObjectContext
            let users = try decoder.decode([SearchResult].self, from: jsonData)
            for user in users{
                user.query = query
            }
            try managedObjectContext.save()
            return (users, true)
        } catch let error {
            print(error)
            return (nil, false)
        }
    }
    
    func fetchFromStorageOrAPI(for query: String, completion: @escaping FetchSearchResultCompletionBlock){
        let managedObjectContext = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<SearchResult>(entityName: SearchController.entityName)
        let predicate = NSPredicate(format: "query == %@", query)
        fetchRequest.predicate = predicate
        do {
            let users = try managedObjectContext.fetch(fetchRequest)
            if users.isEmpty{
                loadItemsFromAPI(for: query, completion: completion)
            }else{
                completion(true, users, nil)
            }
        } catch let error {
            print(error)
        }
    }
    
    func loadItemsFromAPI(for query: String, completion: @escaping FetchSearchResultCompletionBlock) {
        let urlString = String(format: "https://autocomplete.clearbit.com/v1/companies/suggest?query=test")
        guard let url = URL(string: urlString) else {
            completion(false, nil, nil)
            return
        }
        let session = URLSession.shared
        let task = session.dataTask(with: url) { [weak self] (data, response, error) in
            guard let strongSelf = self else { return }
            guard let jsonData = data, error == nil else {
                DispatchQueue.main.async {
                    completion(false, nil, error as NSError?)
                }
                return
            }
            
            let addedModels = strongSelf.parse(for: query, jsonData)
            if addedModels.isSuccess {
                DispatchQueue.main.async {
                    completion(true, addedModels.results, nil)
                }
            } else {
                DispatchQueue.main.async {
                    completion(false, nil, NSError.createError(0, description: "JSON parsing error"))
                }
            }
        }
        task.resume()
    }
}
