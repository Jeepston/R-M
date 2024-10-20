//
//  rmTests.swift
//  rmTests
//
//  Created by Dmitrij Hojkolov on 15.10.2024.
//

import Testing
@testable import rm

struct EndpointTests {

    @Test
    func initialCharactersUrl() {
        let endPoint = Endpoint.characters()
        #expect(endPoint.url?.absoluteString == "https://rickandmortyapi.com/api/character?page=1")
    }

    @Test
    func charactersUrlWithPage() {
        let endPoint = Endpoint.characters(page: 3)
        #expect(endPoint.url?.absoluteString == "https://rickandmortyapi.com/api/character?page=3")
    }

    @Test
    func characterDetails() {
        let endPoint = Endpoint.characterDetails(for: 12)
        #expect(endPoint.url?.absoluteString == "https://rickandmortyapi.com/api/character/12")
    }

    @Test
    func initialSearchCharacters() {
        let endPoint = Endpoint.searchCharacters(name: "rick")
        #expect(endPoint.url?.absoluteString == "https://rickandmortyapi.com/api/character?name=rick&page=1")
    }

    @Test
    func searchCharactersWithPage() {
        let endPoint = Endpoint.searchCharacters(name: "rick", page: 3)
        #expect(endPoint.url?.absoluteString == "https://rickandmortyapi.com/api/character?name=rick&page=3")
    }
}
