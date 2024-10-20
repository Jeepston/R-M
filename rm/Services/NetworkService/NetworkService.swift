//
//  NetworkService.swift
//  rm
//
//  Created by Dmitrij Hojkolov on 16.10.2024.
//

import Foundation

struct NetworkService {
    func performRequest<T: Codable>(with url: URL) async throws -> T {
        let (data, response) = try await URLSession.shared.data(from: url)

        guard let response = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }

        guard (200..<300) ~= response.statusCode else {
            throw NetworkError.invalidStatusCode
        }

        return try decodeJSONData(data: data)
    }
}

private extension NetworkService {
    func decodeJSONData<T: Codable>(data: Data) throws -> T {
        try JSONDecoder().decode(T.self, from: data)
    }
}
