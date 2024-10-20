//
//  CharactersView.swift
//  rm
//
//  Created by Dmitrij Hojkolov on 15.10.2024.
//

import SwiftUI
import SwiftUIIntrospect

struct CharactersListView: View {

    // MARK: - Properties

    @Bindable var viewModel: CharactersListViewModel

    // MARK: - Body

    var body: some View {
        Group {
            switch viewModel.viewState {
            case .loading:
                loadingView
            case .loaded:
                contenView
            case .empty:
                emptyView
            case .error:
                errorView
            }
        }
        .task { await viewModel.getMoreCharacters() }
    }
}

// MARK: - Private functions

private extension CharactersListView {

    @ViewBuilder
    var contenView: some View {
        NavigationSplitView {
            Group {
                if viewModel.isSearching {
                    List {
                        ForEach(viewModel.searchResults) { character in
                            SearchResultRow(viewObject: SearchResultVOMapper.map(character))
                                .listRowInsets(EdgeInsets())
                                .listRowSeparator(.hidden)
                        }

                        if viewModel.hasMoreSearchResults {
                            ProgressView()
                                .onAppear {
                                    Task { await viewModel.searchCharacters() }
                                }
                        }
                    }
                    .listRowSpacing(16)
                } else {
                    List(selection: $viewModel.selectedCharacter) {
                        ForEach(viewModel.characters) { character in
                            CharacterRow(viewObject: viewModel.characterVO(for: character))
                                .overlay {
                                    NavigationLink("", destination: viewModel.destination(for: character))
                                        .opacity(0)
                                }
                                .listRowInsets(EdgeInsets())
                                .listRowSeparator(.hidden)
                        }

                        if viewModel.hasMoreData {
                            ProgressView()
                                .onAppear {
                                    Task { await viewModel.getMoreCharacters() }
                                }
                                .listRowInsets(EdgeInsets())
                                .listRowSeparator(.hidden)
                        }
                    }
                    .listRowSpacing(16)
                    .navigationTitle("Characters")
                }
            }
            .background(Color.backgroundsPrimary)
            .id(viewModel.refreshUi)
            .navigationTitle("Characters")
        } detail: {
            if let character = viewModel.selectedCharacter {
                viewModel.destination(for: character)
            } else {
                Text("Select a character")
            }
        }
        .navigationBarTitleDisplayMode(.large)
        .searchable(text: $viewModel.searchText, isPresented: $viewModel.isSearching, prompt: "Search character")
        .introspect(.searchField, on: .iOS(.v18)) { searchBar in
            // the only properties that were not possible to set up via UIAppearance
            searchBar.searchTextField.layer.cornerRadius = 16
            searchBar.searchTextField.layer.masksToBounds = true
        }
        .onChange(of: viewModel.searchText) {
            viewModel.updateSearch(searchInput: viewModel.searchText)
        }
        .onChange(of: viewModel.isSearching, { _, newValue in
            if !newValue {
                viewModel.resetSearchData()
            }
        })
    }

    @ViewBuilder
    var loadingView: some View {
        NavigationStack {
            ProgressView()
                .controlSize(.large)
                .navigationTitle("Characters")
        }
        .navigationBarTitleDisplayMode(.large)
    }

    @ViewBuilder
    var emptyView: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Headline3Text("No characters at the moment. Try again later")

                Button {
                    Task { await viewModel.getMoreCharacters() }
                } label: {
                    Text("Re-try")
                }
            }
            .padding()
            .navigationTitle("Characters")
        }
        .navigationBarTitleDisplayMode(.large)
    }

    @ViewBuilder
    var errorView: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Headline1Text("There was an error while trying to download characters. Try again later")
                    .foregroundColor(.red)

                Button {
                    Task { await viewModel.getMoreCharacters() }
                } label: {
                    Text("Re-try")
                }
            }
            .padding()
            .navigationTitle("Characters")
        }
        .navigationBarTitleDisplayMode(.large)
    }
}

// MARK: - Preview

#Preview {
    CharactersListView(
        viewModel: .init(
            clients: .init(
                characterClient: .demo,
                databaseClient: .demo
            )
        )
    )
}
