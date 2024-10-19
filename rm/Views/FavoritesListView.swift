//
//  FavoritesListView.swift
//  rm
//
//  Created by Dmitrij Hojkolov on 17.10.2024.
//

import SwiftUI

struct FavoritesListView: View {

    var viewModel: FavoritesListViewModel

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                LazyVStack(spacing: 16) {
                    ForEach(viewModel.characters) { character in
                        NavigationLink(
                            destination: viewModel.destination(for: character)
                        ) {
                            CharacterRow(viewObject: CharacterRowVOMapper.map(character))
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
            .background(Color.backgroundsPrimary)
            .navigationTitle("Favorites")
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
