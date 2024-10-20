//
//  DatabaseService.swift
//  rm
//
//  Created by Dmitrij Hojkolov on 17.10.2024.
//

import SwiftData
import Foundation

final class DatabaseService {
    private let modelContainer: ModelContainer
    private let modelContext: ModelContext

    private var favoriteIds: Set<Int> = []

    @MainActor
    static let shared = DatabaseService()

    @MainActor
    private init() {
        let schema = Schema([FavoriteCharacter.self])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            self.modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
            self.modelContext = modelContainer.mainContext
            self.favoriteIds = try fetchFavoriteIds()
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }

    func append(character: FavoriteCharacter) {
        modelContext.insert(character)
        do {
            try modelContext.save()
            favoriteIds.insert(character.id)
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func fetchCharacters() -> [FavoriteCharacter] {
        do {
            return try modelContext.fetch(FetchDescriptor<FavoriteCharacter>())
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func removeFavoriteCharacterWithId(_ id: Int) {
        do {
            try modelContext.delete(model: FavoriteCharacter.self, where: #Predicate {
                $0.id == id
            })
            if favoriteIds.contains(id) {
                favoriteIds.remove(id)
            }
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func isFavorite(characterId: Int) -> Bool {
        favoriteIds.contains(characterId)
    }

    // To observe database changes
    func favoriteIdsStream() -> AsyncStream<Set<Int>> {
           AsyncStream { continuation in
               let task = Task {
                   for await _ in NotificationCenter.default.notifications(
                       named: .NSPersistentStoreRemoteChange
                   ).map({ _ in () }) {
                       continuation.yield(self.favoriteIds)
                   }
               }

               continuation.onTermination = { _ in
                   task.cancel()
               }

               continuation.yield(self.favoriteIds)
           }
       }

    private func fetchFavoriteIds() throws -> Set<Int> {
        var fetchDescriptor = FetchDescriptor<FavoriteCharacter>()
        fetchDescriptor.propertiesToFetch = [\.id]
        let ids = try modelContext.fetch(fetchDescriptor)
        return Set(ids.map(\.id))
    }
}
