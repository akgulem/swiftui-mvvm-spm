//
//  File.swift
//  
//
//  Created by Emrah Akgül on 25.01.2021.
//

import Foundation

public struct RepoOwnerDTO: Decodable {
    public let id: Int?
    public let login: String?
    public let avatarURL: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case login = "login"
        case avatarURL = "avatar_url"
    }
}
