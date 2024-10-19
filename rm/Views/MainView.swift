//
//  MainView.swift
//  rm
//
//  Created by Dmitrij Hojkolov on 15.10.2024.
//

import SwiftUI


struct MainView: View {

    // MARK: - Body

    var body: some View {
        TabView {
            CharactersListView(
                viewModel: .init(
                    clients: .init(
                        characterClient: .live,
                        databaseClient: .live
                    )
                )
            )
            .tabItem {
                Image(.characters)
            }
            
            FavoritesListView(
                viewModel: .init(
                    clients: .init(
                        characterClient: .live,
                        databaseClient: .live
                    )
                )
            )
            .tabItem {
                Image(.favorites)
            }
        }
    }
}

// MARK: - Preview

#Preview {
    MainView()
}
