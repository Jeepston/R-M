//
//  FavoriteCharacterMapper.swift
//  rm
//
//  Created by Dmitrij Hojkolov on 17.10.2024.
//

enum FavoriteCharacterMapper {

    static func map(_ character: Character) -> FavoriteCharacter {
        .init(
            id: character.id,
            name: character.name,
            status: character.status,
            image: character.image,
            url: character.url
        )
    }
}
