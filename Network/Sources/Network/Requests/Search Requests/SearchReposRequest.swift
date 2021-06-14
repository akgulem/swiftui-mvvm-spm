//
//  File.swift
//  
//
//  Created by Emrah Akgül on 25.01.2021.
//

import Foundation

struct SearchReposRequest: GetRequest {
    public var path: String = "/search/repositories"
    public var parameters: [URLQueryItem]
    public var headers: [String : String] = [:]
}
