//
//  CharacterService.swift
//  rm
//
//  Created by Dmitrij Hojkolov on 16.10.2024.
//

struct CharacterService {
    let networkService: NetworkService

    func getCharacters(_ page: Int = 1) async throws -> CharacterResponseModel {
        let endPoint = Endpoint.characters(page: page)
        if let url = endPoint.url {
            return try await networkService.performRequest(with: url)
        }

        throw NetworkError.invalidUrl
    }

    func getCharacter(_ id: Int) async throws -> Character {
        let endPoint = Endpoint.characterDetails(for: id)
        if let url = endPoint.url {
            return try await networkService.performRequest(with: url)
        }

        throw NetworkError.invalidUrl
    }

    func searchCharacters(_ name: String, _ page: Int) async throws -> CharacterResponseModel {
        let endPoint = Endpoint.searchCharacters(name: name, page: page)
        if let url = endPoint.url {
            return try await networkService.performRequest(with: url)
        }

        throw NetworkError.invalidUrl
    }
}
