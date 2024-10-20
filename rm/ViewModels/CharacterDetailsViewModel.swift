//
//  CharacterDetailsViewModel.swift
//  rm
//
//  Created by Dmitrij Hojkolov on 16.10.2024.
//

import Foundation

@Observable @MainActor
final class CharacterDetailsViewModel {

    // MARK: - Properties

    struct Clients {
        let characterClient: CharacterClient
        let databaseClient: DatabaseClient
    }

    private let clients: Clients
    private let characterId: Int

    // MARK: - State

    var viewState: ViewState = .loading
    var character: Character = .demo
    var isFavorite = false
    var showErrorAlert = false

    init(clients: Clients, characterId: Int) {
        self.clients = clients
        self.characterId = characterId
    }

    // MARK: - Functions

    func getCharacter() async {
        // When used with List, task is called twice, and on of the tasks is cancelled
        guard !Task.isCancelled else {
            return
        }

        do {
            character = try await clients.characterClient.getCharacterDetails(characterId)
            isFavorite = isChatacterFavorite()
            viewState = .loaded
        } catch {
            viewState = .error
            showErrorAlert = true
            debugPrint(error)
        }
    }

    func didTapFavoriteButton() {
        if clients.databaseClient.isFavorite(characterId) {
            clients.databaseClient.removeFavorite(characterId)
            isFavorite = false
        } else {
            let favoriteCharacter = FavoriteCharacterMapper.map(character)
            clients.databaseClient.addFavorite(favoriteCharacter)
            isFavorite = true
        }
    }

    func isChatacterFavorite() -> Bool {
        clients.databaseClient.isFavorite(characterId)
    }
}
