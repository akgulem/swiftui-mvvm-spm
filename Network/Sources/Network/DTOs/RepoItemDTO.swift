//
//  File.swift
//  
//
//  Created by Emrah Akgül on 25.01.2021.
//

import Foundation

public struct RepoItemDTO: Decodable, Identifiable {
    public let id: Int?
    public let name: String?
    public let fullName: String?
    public let owner: RepoOwnerDTO?
    public let forksCount: Double?
    public let defaultBranchName: String?
    public let programmingLanguage: String?
    public let isPrivate: Bool?
}
