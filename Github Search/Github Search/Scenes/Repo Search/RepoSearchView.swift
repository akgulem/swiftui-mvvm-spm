//
//  ContentView.swift
//  Github Search
//
//  Created by Emrah Akgül on 13.06.2021.
//

import SwiftUI

struct RepoSearchView: View {

    @ObservedObject var viewModel = RepoSearchViewModel()
    @State private var searchHelper: SearchHelper!
    @State var searchText = ""
    @State var searching = false

    var body: some View {
        VStack(alignment: .leading) {
            SearchBar(searchText: $searchText, searching: $searching)
            List(viewModel.repoItemDTOs) { repoItemDTO in
                VStack(alignment: .leading) {
                    Text(repoItemDTO.name ?? "")
                }
            }
            .onAppear {
                searchHelper = SearchHelper(interval: Constants.throttlingTime) { (text) in
                    viewModel.getResults(text: text)
                }
            }
            .onChange(of: searchText, perform: { (text) in
                searchHelper.handleTyping(text: text)
            })
            .navigationTitle(Constants.title)
            .listStyle(GroupedListStyle())
        }
    }
}

struct RepoSearchView_Previews: PreviewProvider {
    static var previews: some View {
        RepoSearchView()
    }
}

extension RepoSearchView {

    enum Constants {

        static let title = "Repos"
        static let throttlingTime: Double = 1.0
    }
}
