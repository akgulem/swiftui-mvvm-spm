//
//  File.swift
//  
//
//  Created by Emrah Akgül on 25.01.2021.
//

import Foundation

public struct SearchReposContainerDTO: Decodable {
    public let totalCount: Int?
    public let items: [RepoItemDTO]?
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case items = "items"
    }
}
