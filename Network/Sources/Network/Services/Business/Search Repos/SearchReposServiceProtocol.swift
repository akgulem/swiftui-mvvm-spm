//
//  File.swift
//  
//
//  Created by Emrah Akgül on 25.01.2021.
//

import Foundation

public protocol SearchReposServiceProtocol {
    func searchRepos(text: String?, completion: @escaping (Result<SearchReposContainerDTO?, Error>) -> Void)
}
