//
//  RepoSearchViewModel.swift
//  Github Search
//
//  Created by Emrah Akgül on 14.06.2021.
//

import Foundation
import Network

final class RepoSearchViewModel: ObservableObject {

    @Published var repoItemDTOs = [RepoItemDTO]()

    private var searchReposService: SearchReposServiceProtocol

    init(searchReposService: SearchReposServiceProtocol = SearchReposAPIService()) {
        self.searchReposService = searchReposService
    }

    func getResults(text: String = "") {
        searchReposService.searchRepos(text: text) { [weak self] (result) in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case .success(let reposContainerDTO):
                    if let repoItemDTOs = reposContainerDTO?.items {
                        self.repoItemDTOs = repoItemDTOs
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
