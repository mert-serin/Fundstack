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
        loadItemsFromAPI(for: query, completion: completionBlock)
    }
}

private extension SearchController {
    
    func loadItemsFromAPI(for query: String, completion: @escaping FetchSearchResultCompletionBlock) {
        let urlString = String(format: "https://autocomplete.clearbit.com/v1/companies/suggest?query=test")
        guard let url = URL(string: urlString) else {
            completion(false, nil, nil)
            return
        }
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            print(response)
        }
        task.resume()
    }
}
