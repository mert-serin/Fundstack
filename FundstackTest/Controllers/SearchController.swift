//
//  SearchController.swift
//  FundstackTest
//
//  Created by Mert Serin on 9.04.2019.
//  Copyright © 2019 Mert Serin. All rights reserved.
//

import Foundation

typealias FetchSearchResultCompletionBlock = (_ success: Bool, _ result: [SearchResult]?, _ error: NSError?) -> Void

protocol SearchControllerProtocol {
    func fetchItems(for query: String, _ completionBlock: @escaping FetchSearchResultCompletionBlock)
}

extension SearchControllerProtocol {
    func fetchItems(for query: String, _ completionBlock: @escaping FetchSearchResultCompletionBlock) {}
}


class SearchController: SearchControllerProtocol {
    
}
