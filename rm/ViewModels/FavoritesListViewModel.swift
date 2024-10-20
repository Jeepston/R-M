//
//  FavoritesListViewModel.swift
//  rm
//
//  Created by Dmitrij Hojkolov on 17.10.2024.
//

import SwiftUI

@Observable @MainActor
final class FavoritesListViewModel {

    // MARK: - Properties

    struct Clients {
        let characterClient: CharacterClient
        let databaseClient: DatabaseClient
    }

    private let clients: Clients

    // MARK: - State

    var characters: [FavoriteCharacter] = []
    var selectedCharacter: FavoriteCharacter?

    init(clients: Clients) {
        self.clients = clients
    }

    // MARK: - Functions

    func getCharacters() async {
        characters = clients.databaseClient.fetchFavorites()
    }

    func destination(for character: FavoriteCharacter) -> some View {
        CharacterDetailsView(
            viewModel: .init(
                clients: .init(characterClient: clients.characterClient, databaseClient: clients.databaseClient),
                characterId: character.id
            )
        )
    }
}
