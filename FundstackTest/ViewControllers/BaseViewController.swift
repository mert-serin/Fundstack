//
//  BaseViewController.swift
//  FundstackTest
//
//  Created by Mert Serin on 10.04.2019.
//  Copyright © 2019 Mert Serin. All rights reserved.
//

import UIKit
class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTap()
    }
    
    func hideKeyboardWhenTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(BaseViewController.didTapAnywhereOnBase))
        tap.numberOfTouchesRequired = 1
        tap.numberOfTapsRequired = 1
        tap.cancelsTouchesInView = true
        self.view.addGestureRecognizer(tap)
    }
    
    @objc private func didTapAnywhereOnBase() {
        self.view.endEditing(true)
    }
}
