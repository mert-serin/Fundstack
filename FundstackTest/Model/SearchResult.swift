//
//  SearchResult.swift
//  FundstackTest
//
//  Created by Mert Serin on 9.04.2019.
//  Copyright © 2019 Mert Serin. All rights reserved.
//

import Foundation
import CoreData

class SearchResult: NSManagedObject, Codable {
    enum CodingKeys: String, CodingKey {
        case name
        case domain
        case logo
        case query
    }
    
    // MARK: - Core Data Managed Object
    @NSManaged var name: String?
    @NSManaged var domain: String?
    @NSManaged var logo: String?
    @NSManaged var query: String?
    
    // MARK: - Decodable
    required convenience init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "SearchResult", in: managedObjectContext) else {
                fatalError("Failed to decode SearchResult")
        }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.domain = try container.decodeIfPresent(String.self, forKey: .domain)
        self.logo = try container.decodeIfPresent(String.self, forKey: .logo)
        self.query = try container.decodeIfPresent(String.self, forKey: .query)
    }
    
    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(domain, forKey: .domain)
        try container.encode(logo, forKey: .logo)
        try container.encode(query, forKey: .query)
    }
}
