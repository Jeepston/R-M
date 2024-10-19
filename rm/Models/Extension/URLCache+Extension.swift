//
//  URLCache+Extension.swift
//  rm
//
//  Created by Dmitrij Hojkolov on 17.10.2024.
//

import Foundation

extension URLCache {

    static let imageCache = URLCache(memoryCapacity: 512_000_000, diskCapacity: 10_000_000_000)
}
