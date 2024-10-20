//
//  CharactersViewModel.swift
//  rm
//
//  Created by Dmitrij Hojkolov on 15.10.2024.
//

import Combine
import SwiftUI

@Observable @MainActor
final class CharactersListViewModel {

    // MARK: - Properties

    struct Clients {
        let characterClient: CharacterClient
        let databaseClient: DatabaseClient
    }

    private let clients: Clients

    // MARK: - State

    var viewState: ViewState = .loading

    var characters: [Character] = []
    var selectedCharacter: Character?
    var hasMoreData = false

    var searchResults: [Character] = []
    var hasMoreSearchResults = false
    var isSearching = false
    var searchText = ""
    private var currentSearchPage = 1
    private var searchInputSubject = PassthroughSubject<String, Never>()
    private var cancellables = Set<AnyCancellable>()

    // Used as a state var to trigger UI refresh after changes in DB
    var refreshUi = false

    private var isFirstLoad = true
    private var currentPage = 1

    init(clients: Clients) {
        self.clients = clients

        searchInputSubject
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink { [weak self] _ in
                Task { await self?.searchCharacters() }
            }
            .store(in: &cancellables)

        Task { await self.observeDbChanges() }
    }

    // MARK: - Functions

    func getMoreCharacters() async {
        if isFirstLoad {
            viewState = .loading
        }

        do {
            let response = try await clients.characterClient.getCharacters(currentPage)
            self.characters.append(contentsOf: response.results)
            currentPage += 1
            hasMoreData = response.info.next != nil
            if self.characters.isEmpty {
                viewState = .empty
            } else if viewState != .loaded {
                viewState = .loaded
                isFirstLoad = false
            }
        } catch {
            viewState = .error
            debugPrint(error)
        }
    }

    func searchCharacters() async {
        do {
            let response = try await clients.characterClient.searchCharacters(searchText, currentSearchPage)
            self.searchResults.append(contentsOf: response.results)
            currentSearchPage += 1
            hasMoreSearchResults = response.info.next != nil
        } catch {
            viewState = .error
        }
    }

    func destination(for character: Character) -> some View {
        CharacterDetailsView(
            viewModel: .init(
                clients: .init(characterClient: clients.characterClient, databaseClient: clients.databaseClient),
                characterId: character.id
            )
        )
    }

    func characterVO(for character: Character) -> CharacterRow.ViewObject {
        let isFavorite = clients.databaseClient.isFavorite(character.id)
        return CharacterRowVOMapper.map(character, isFavorite: isFavorite)
    }

    func updateSearch(searchInput: String) {
        if !searchInput.isEmpty {
            searchInputSubject.send(searchInput.trimmingCharacters(in: .whitespacesAndNewlines))
        }
    }

    func resetSearchData() {
        searchResults = []
        hasMoreSearchResults = false
        searchText = ""
        currentSearchPage = 1
    }
}

// MARK: - Private functions

private extension CharactersListViewModel {
    func observeDbChanges() async {
        for await _ in clients.databaseClient.favoriteIdsStream() {
            refreshUi.toggle()
        }
    }
}
