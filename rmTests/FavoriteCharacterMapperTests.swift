//
//  FavoriteCharacterMapperTests.swift
//  rmTests
//
//  Created by Dmitrij Hojkolov on 20.10.2024.
//

import Testing
@testable import rm

struct FavoriteCharacterMapperTests {

    @Test
    func mapCharacter() {
        let vo = FavoriteCharacterMapper.map(.demo)
        #expect(vo.id == 1)
        #expect(vo.name == "Rick Sanchez")
        #expect(vo.status == "Alive")
        #expect(vo.image == "https://rickandmortyapi.com/api/character/avatar/1.jpeg")
        #expect(vo.url == "https://rickandmortyapi.com/api/character/1")
    }

}
