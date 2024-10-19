//
//  CharactersView.swift
//  rm
//
//  Created by Dmitrij Hojkolov on 15.10.2024.
//

import SwiftUI
import SwiftUIIntrospect

struct CharactersListView: View {

    @Bindable var viewModel: CharactersListViewModel

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
                case .isSearching:
                    EmptyView()
                }
            }
            .task { await viewModel.getMoreCharacters() }
    }

    @ViewBuilder
    private var contenView: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                LazyVStack(spacing: 16) {
                    if viewModel.isSearching {
                        ForEach(viewModel.searchResults) { character in
                            SearchResultRow(viewObject: SearchResultVOMapper.map(character))
                        }

                        if viewModel.hasMoreSearchResults {
                            ProgressView()
                                .onAppear {
                                    Task { await viewModel.searchCharacters() }
                                }
                        }
                    } else {
                        ForEach(viewModel.characters) { character in
                            NavigationLink(
                                destination: viewModel.destination(for: character)
                            ) {
                                CharacterRow(viewObject: viewModel.characterVO(for: character))
                            }
                        }

                        if viewModel.hasMoreData {
                            ProgressView()
                                .onAppear {
                                    Task { await viewModel.getMoreCharacters() }
                                }
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
            .background(Color.backgroundsPrimary)
            .id(viewModel.refreshUi)
            .navigationTitle("Characters")
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

                Button(action: {
                    Task { await viewModel.getMoreCharacters() }
                }) {
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

                Button(action: {
                    Task { await viewModel.getMoreCharacters() }
                }) {
                    Text("Re-try")
                }
            }
            .padding()
            .navigationTitle("Characters")
        }
        .navigationBarTitleDisplayMode(.large)
    }
}


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
