//
//  FavoritesListView.swift
//  rm
//
//  Created by Dmitrij Hojkolov on 17.10.2024.
//

import SwiftUI

struct FavoritesListView: View {

    // MARK: - Properties

    @Bindable var viewModel: FavoritesListViewModel

    // MARK: - Body

    var body: some View {
        NavigationSplitView {
            List(viewModel.characters, selection: $viewModel.selectedCharacter) { character in
                    CharacterRow(viewObject: CharacterRowVOMapper.map(character))
                        .overlay {
                            NavigationLink("", destination: viewModel.destination(for: character))
                                .opacity(0)
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

// MARK: - Preview

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
