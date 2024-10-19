//
//  CharacterRowVOMapper.swift
//  rm
//
//  Created by Dmitrij Hojkolov on 16.10.2024.
//

import Foundation

enum CharacterRowVOMapper {

    static func map(_ character: Character, isFavorite: Bool) -> CharacterRow.ViewObject {
        .init(
            imageUrl: URL(string: character.image),
            name: character.name,
            status: character.status,
            isFavorite: isFavorite
        )
    }

    static func map(_ favoriteChracter: FavoriteCharacter) -> CharacterRow.ViewObject {
        .init(
            imageUrl: URL(string: favoriteChracter.image),
            name: favoriteChracter.name,
            status: favoriteChracter.status,
            isFavorite: true
        )
    }
}
