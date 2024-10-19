//
//  CharacterClient.swift
//  rm
//
//  Created by Dmitrij Hojkolov on 16.10.2024.
//

import Combine

struct CharacterClient {
    var getCharacters: (_ page: Int) async throws -> CharacterResponseModel
    var searchCharacters: (_ name: String, _ page: Int) async throws -> CharacterResponseModel
    var getCharacterDetails: (_ id: Int) async throws -> Character
}
