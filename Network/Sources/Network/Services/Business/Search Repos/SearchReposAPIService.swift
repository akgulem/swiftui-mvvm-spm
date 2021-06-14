//
//  File.swift
//  
//
//  Created by Emrah Akgül on 25.01.2021.
//

import Foundation

public final class SearchReposAPIService: SearchReposServiceProtocol {
    public init() {}
    
    public func searchRepos(text: String?, completion: @escaping (Result<SearchReposContainerDTO?, Error>) -> Void) {
        
        guard let searchText = text, !searchText.isEmpty else { return }
        
        let textQueryItem = URLQueryItem(name: "q", value: text ?? "")
        
        let parameters = [textQueryItem]
        let searchReposRequest = SearchReposRequest(parameters: parameters, headers: [:])
        
        NetworkManager.default.makeRequest(request: searchReposRequest) { (searchReposContainer: SearchReposContainerDTO?, error: Error?) in
            if let error = error {
                completion(.failure(error))
                return
            }
            if let searchReposContainer = searchReposContainer {
                completion(.success(searchReposContainer))
            }
            else {
                completion(.failure(ServiceError.notRetrieved))
            }
        }
    }
}
