//
//  Extensions.swift
//  FundstackTest
//
//  Created by Mert Serin on 9.04.2019.
//  Copyright © 2019 Mert Serin. All rights reserved.
//

import Foundation

public extension CodingUserInfoKey {
    static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")
}

extension NSError {
    static func createError(_ code: Int, description: String) -> NSError {
        return NSError(domain: "com.brutecodes.FundstackTest",
                       code: 400,
                       userInfo: [
                        "NSLocalizedDescription" : description
            ])
    }
}
