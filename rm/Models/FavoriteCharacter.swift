//
//  FavoriteCharacter.swift
//  rm
//
//  Created by Dmitrij Hojkolov on 15.10.2024.
//

import SwiftData


@Model
final class FavoriteCharacter {
    var id: Int
    var name: String
    var status: String
    var image: String
    var url: String

    init(id: Int, name: String, status: String, image: String, url: String) {
        self.id = id
        self.name = name
        self.status = status
        self.image = image
        self.url = url
    }
}
