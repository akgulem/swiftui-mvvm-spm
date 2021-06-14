//
//  SearchBar.swift
//  Github Search
//
//  Created by Emrah Akgül on 13.06.2021.
//

import SwiftUI

struct SearchBar: View {

    @Binding var searchText: String
    @Binding var searching: Bool

    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color(Constants.foregroundColorName))
            HStack {
                Image(systemName: "magnifyingglass")
                TextField(Constants.placeHolder, text: $searchText) { startedEditing in
                    if startedEditing {
                        withAnimation {
                            searching = true
                        }
                    }
                } onCommit: {
                    withAnimation {
                        searching = false
                    }
                }
            }
            .foregroundColor(.gray)
            .padding(.leading, Constants.padding)
        }
        .frame(height: Constants.height)
        .cornerRadius(Constants.cornerRadius)
        .padding()
    }
}

struct SearchBar_Previews: PreviewProvider {

    @State static var searchText = "Search"
    @State static var searching = false

    static var previews: some View {
        SearchBar(searchText: $searchText, searching: $searching)
    }
}

extension SearchBar {

    enum Constants {

        static let foregroundColorName = "LightGray"
        static let placeHolder = "Search"
        static let padding: CGFloat = 13
        static let height: CGFloat = 40
        static let cornerRadius: CGFloat = 13
    }
}
