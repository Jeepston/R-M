//
//  RMCharacter.swift
//  rm
//
//  Created by Dmitrij Hojkolov on 15.10.2024.
//

struct ResponseInfo: Codable {
    let count: Int
    let pages: Int
    let next: String?
}

struct CharacterResponseModel: Codable {
    let info: ResponseInfo
    let results: [Character]

    static let empty: Self = .init(info: .init(count: 0, pages: 0, next: nil), results: [])
}

struct Character: Codable, Identifiable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: Location
    let location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

struct Location: Codable {
    let name: String
    let url: String
}


// MARK: - Demo

extension Character {
    static let demo: Self = .init(
        id: 1,
        name: "Rick Sanchez",
        status: "Alive",
        species: "Human",
        type: "",
        gender: "Male",
        origin: .init(name: "Earth", url: "https://rickandmortyapi.com/api/location/1"),
        location: .init(name: "Earth", url: "https://rickandmortyapi.com/api/location/20"),
        image: "",
        episode: ["https://rickandmortyapi.com/api/episode/1"],
        url: "https://rickandmortyapi.com/api/character/1",
        created: "2017-11-04T18:48:46.250Z"
    )
}
