//
//  SearchResultVOMapper.swift
//  rmTests
//
//  Created by Dmitrij Hojkolov on 20.10.2024.
//

import Testing
@testable import rm

struct SearchResultVOMapperTests {

    @Test
    func searchRestultMap()  {
        let vo = SearchResultVOMapper.map(.demo)
        #expect(vo.name == "Rick Sanchez")
        #expect(vo.status == "Alive")
        #expect(vo.imageUrl?.absoluteString == "https://rickandmortyapi.com/api/character/avatar/1.jpeg")
    }

}
