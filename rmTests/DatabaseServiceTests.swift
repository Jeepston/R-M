//
//  DatabaseServiceTests.swift
//  rmTests
//
//  Created by Dmitrij Hojkolov on 20.10.2024.
//

import Testing
@testable import rm

struct DatabaseServiceTests {

    @Test @MainActor
    func etst() {
        let dbClient = DatabaseClient.inMemory
        let character = FavoriteCharacter(id: 12, name: "Rick", status: "Alive", image: "", url: "")
        dbClient.addFavorite(character)
        #expect(dbClient.fetchFavorites().count == 1)
        #expect(dbClient.isFavorite(character.id))
        #expect(!dbClient.isFavorite(13))

        dbClient.removeFavorite(character.id)
        #expect(dbClient.fetchFavorites().isEmpty)
        #expect(!dbClient.isFavorite(character.id))
    }
}
