//
//  FavoritesListView.swift
//  rm
//
//  Created by Dmitrij Hojkolov on 17.10.2024.
//

import SwiftUI

struct FavoritesListView: View {

    @Bindable var viewModel: FavoritesListViewModel

    var body: some View {
        NavigationSplitView {
            List(viewModel.characters, selection: $viewModel.selectedCharacter) { character in
                Button(action: {
                    debugPrint("Selected character: \(character.id)")
                    viewModel.selectedCharacter = character
                }) {
                    CharacterRow(viewObject: CharacterRowVOMapper.map(character))
                }
                .listRowInsets(EdgeInsets())
                .listRowSeparator(.hidden)
            }
            .listRowSpacing(16)
            .background(Color.backgroundsPrimary)
            .navigationTitle("Favorites")
        } detail: {
            if let character = viewModel.selectedCharacter {
                viewModel.destination(for: character)
            } else {
                Text("Select a character")
            }
        }
        .navigationBarTitleDisplayMode(.large)
        .task { await viewModel.getCharacters() }
    }
}

#Preview {
    FavoritesListView(
        viewModel: .init(
            clients: .init(
                characterClient: .demo,
                databaseClient: .demo
            )
        )
    )
}
