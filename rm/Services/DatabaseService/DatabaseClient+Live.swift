//
//  DatabaseClient+Live.swift
//  rm
//
//  Created by Dmitrij Hojkolov on 17.10.2024.
//

extension DatabaseClient {

    static var live: Self {
        let service = DatabaseService.shared
        return .init(
            fetchFavorites: service.fetchCharacters,
            addFavorite: service.append,
            removeFavorite: service.removeFavoriteCharacterWithId,
            isFavorite: service.isFavorite,
            favoriteIdsStream: service.favoriteIdsStream
        )
    }
}
