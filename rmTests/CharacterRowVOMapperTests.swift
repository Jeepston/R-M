//
//  CharacterRowVOMapperTests.swift
//  rmTests
//
//  Created by Dmitrij Hojkolov on 20.10.2024.
//

import Testing
@testable import rm

struct CharacterRowVOMapperTests {

    @Test
    func mapCharacter() {
        let vo = CharacterRowVOMapper.map(.demo, isFavorite: false)
        #expect(vo.name == "Rick Sanchez")
        #expect(vo.status == "Alive")
        #expect(vo.imageUrl?.absoluteString == "https://rickandmortyapi.com/api/character/avatar/1.jpeg")
        #expect(!vo.isFavorite)
    }

    @Test
    func mapFavoriteCharacter() {
        let favoriteCharacter = FavoriteCharacter(id: 1, name: "Rick Sanchez", status: "Alive", image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg", url: "")
        let vo = CharacterRowVOMapper.map(favoriteCharacter)
        #expect(vo.name == "Rick Sanchez")
        #expect(vo.status == "Alive")
        #expect(vo.imageUrl?.absoluteString == "https://rickandmortyapi.com/api/character/avatar/1.jpeg")
        #expect(vo.isFavorite)
    }
}
