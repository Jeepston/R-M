//
//  SearchResultVOMapper.swift
//  rm
//
//  Created by Dmitrij Hojkolov on 19.10.2024.
//

import Foundation

enum SearchResultVOMapper {

    static func map(_ character: Character) -> SearchResultRow.ViewObject {
        .init(
            imageUrl: URL(string: character.image),
            name: character.name,
            status: character.status
        )
    }
}
