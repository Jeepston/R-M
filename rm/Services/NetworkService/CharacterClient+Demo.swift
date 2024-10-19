//
//  CharacterClient+Demo.swift
//  rm
//
//  Created by Dmitrij Hojkolov on 16.10.2024.
//
import Combine

extension CharacterClient {

    static var demo: Self {
        .init(
            getCharacters: { _ in
                .init(info: .init(count: 10, pages: 2, next: nil), results: [.demo])
            },
            searchCharacters: { _, _ in
                .init(info: .init(count: 10, pages: 2, next: nil), results: [.demo])
            },
            getCharacterDetails: { _ in .demo }
        )
    }
}
