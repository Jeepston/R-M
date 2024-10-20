//
//  Endpoint.swift
//  rm
//
//  Created by Dmitrij Hojkolov on 15.10.2024.
//

import Foundation

struct Endpoint {
    let path: String
    let queryItems: [URLQueryItem]

    init(path: String, queryItems: [URLQueryItem] = []) {
        self.path = path
        self.queryItems = queryItems
    }

    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "rickandmortyapi.com"
        components.path = "/api/\(path)"
        if !queryItems.isEmpty {
            components.queryItems = queryItems
        }

        return components.url
    }
}

extension Endpoint {
    static func characters(page: Int = 1) -> Endpoint {
        Endpoint(
            path: "character",
            queryItems: [
                URLQueryItem(name: "page", value: String(page))
            ]
        )
    }

    static func characterDetails(for id: Int) -> Endpoint {
        Endpoint(path: "character/\(id)")
    }

    static func searchCharacters(name: String, page: Int = 1) -> Endpoint {
        Endpoint(
            path: "character",
            queryItems: [
                URLQueryItem(name: "name", value: name),
                URLQueryItem(name: "page", value: String(page))
            ]
        )
    }
}
