//
//  FavoritesListViewModelTests.swift
//  rmTests
//
//  Created by Dmitrij Hojkolov on 20.10.2024.
//

import Testing
@testable import rm

struct FavoritesListViewModelTests {

    @Test @MainActor
    func viewModelCharacters() async {
        let dbClient = DatabaseClient.inMemory
        let character1 = FavoriteCharacter(id: 1, name: "Rick", status: "Alive", image: "", url: "")
        let character2 = FavoriteCharacter(id: 2, name: "Morty", status: "Alive", image: "", url: "")
        dbClient.addFavorite(character1)
        dbClient.addFavorite(character2)

        let viewModel = FavoritesListViewModel(clients: .init(characterClient: .demo, databaseClient: dbClient))
        await viewModel.getCharacters()
        #expect(viewModel.characters.count == 2)
    }

}
