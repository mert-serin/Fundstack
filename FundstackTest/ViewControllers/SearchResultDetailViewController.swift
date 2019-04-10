//
//  SearchResultDetailViewController.swift
//  FundstackTest
//
//  Created by Mert Serin on 9.04.2019.
//  Copyright © 2019 Mert Serin. All rights reserved.
//

import UIKit

class SearchResultDetailViewController: UIViewController {

    //MARK: Outletes
    @IBOutlet weak var companyLogoImageView: UIImageView!
    
    //MARK: Variables
    var searchedResult:SearchResult!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let imageURL = URL(string: searchedResult.logo!){
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: imageURL){
                    //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                    DispatchQueue.main.async {
                        self.companyLogoImageView.image = UIImage(data: data)
                    }
                }
            }
        }
        
        
    }
    
    

}
