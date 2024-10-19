//
//  DatabaseClient.swift
//  rm
//
//  Created by Dmitrij Hojkolov on 17.10.2024.
//

@MainActor
struct DatabaseClient {
    var fetchFavorites: () -> [FavoriteCharacter]
    var addFavorite: (FavoriteCharacter) -> Void
    var removeFavorite: (_ id: Int) -> Void
    var isFavorite: (_ id: Int) -> Bool
    var favoriteIdsStream: () -> AsyncStream<Set<Int>>
}

