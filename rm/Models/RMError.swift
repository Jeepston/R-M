//
//  RMError.swift
//  rm
//
//  Created by Dmitrij Hojkolov on 19.10.2024.
//

enum NetworkError: Error {
    case invalidUrl
    case invalidResponse
    case invalidStatusCode
}

enum RMError: Error {
    case notAvailableInDemo
}
