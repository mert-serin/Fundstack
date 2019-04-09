//
//  SearchedResultCell.swift
//  FundstackTest
//
//  Created by Mert Serin on 9.04.2019.
//  Copyright © 2019 Mert Serin. All rights reserved.
//

import UIKit

class SearchedResultCell: UICollectionViewCell {
    
    @IBOutlet private weak var companyNameLabel: UILabel!
    
    var searchedResult: SearchResult!{
        didSet{
            companyNameLabel.text = searchedResult.name ?? "-"
        }
    }
    
    typealias OnElementSelected = ((SearchResult) -> Void)
    var onElementSelected: OnElementSelected!
    
    @IBAction func itemSelectedAction(_ sender: UIButton) {
        onElementSelected(searchedResult)
    }
    
    override func prepareForReuse() {
        companyNameLabel.text = nil
    }
}
