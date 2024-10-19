//
//  CharacterClient+Live.swift
//  rm
//
//  Created by Dmitrij Hojkolov on 16.10.2024.
//

extension CharacterClient {

    static var live: Self {
        let service = CharacterService(networkService: NetworkService())
        return .init(
            getCharacters: service.getCharacters,
            searchCharacters: service.searchCharacters,
            getCharacterDetails: service.getCharacter
        )
    }
}
