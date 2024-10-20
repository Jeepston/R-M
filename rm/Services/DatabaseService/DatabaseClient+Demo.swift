//
//  DatabaseClient+Demo.swift
//  rm
//
//  Created by Dmitrij Hojkolov on 17.10.2024.
//

extension DatabaseClient {

    static var demo: Self {
        .init(
            fetchFavorites: { [] },
            addFavorite: { _ in },
            removeFavorite: { _ in },
            isFavorite: { _ in Bool.random() },
            favoriteIdsStream: { AsyncStream<Set<Int>> { _ in } }
        )
    }

    // For testing
    static var inMemory: Self {
        let service = DatabaseService(isInMemory: true)
        return .init(
            fetchFavorites: service.fetchCharacters,
            addFavorite: service.append,
            removeFavorite: service.removeFavoriteCharacterWithId,
            isFavorite: service.isFavorite,
            favoriteIdsStream: service.favoriteIdsStream
        )
    }
}
