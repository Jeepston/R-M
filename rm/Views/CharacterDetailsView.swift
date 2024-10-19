//
//  CharacterDetailsView.swift
//  rm
//
//  Created by Dmitrij Hojkolov on 16.10.2024.
//

import SwiftUI

struct CharacterDetailsView: View {

    @Bindable var viewModel: CharacterDetailsViewModel

    private let imageSize = 140.0

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                HStack(alignment: .top, spacing: 16) {
                    AsyncImage(url: URL(string: viewModel.character.image)) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(8)
                    } placeholder: {
                        Rectangle()
                            .fill(.backgroundsSecondary)
                            .frame(size: imageSize)
                            .cornerRadius(8)
                            .shimmer()
                    }
                    .frame(size: imageSize)

                    VStack(alignment: .leading, spacing: 16) {
                        ParagraphMediumText("Name")
                            .foregroundStyle(Color.foregroundsSecondary)

                        Headline2Text(viewModel.character.name)
                            .lineLimit(2)
                    }

                    Spacer()

                    Button(action: {
                        viewModel.didTapFavoriteButton()
                    }) {
                        Image(viewModel.isFavorite ? .favFull : .favorites)
                            .resizable()
                            .frame(size: 30)
                            .foregroundStyle(viewModel.isFavorite ? .accent : Color.iconsSecondary)
                    }

                }
                .padding(.horizontal, 16)

                Divider()
                    .overlay(Color.foregroundsSeparator)
                    .padding(.top, 16)
                    .padding(.bottom, 20)

                VStack(alignment: .leading, spacing: 20) {
                    CharacterDetailStatusRow(label: "Status", value: viewModel.character.status)
                    CharacterDetailStatusRow(label: "Species", value: viewModel.character.species)
                    CharacterDetailStatusRow(label: "Type", value: viewModel.character.type)
                    CharacterDetailStatusRow(label: "Gender", value: viewModel.character.gender)
                    CharacterDetailStatusRow(label: "Origin", value: viewModel.character.origin.name)
                    CharacterDetailStatusRow(label: "Location", value: viewModel.character.location.name)
                }
                .padding(.horizontal, 24)
            }
            .shimmer(when: .constant(viewModel.viewState == .loading))
            .padding(.top, 16)
            .padding(.bottom, 24)
            .background(Color.cardBackground)
            .cornerRadius(16)
            .shadow(color: .detailCardShadow, radius: 16, x: 0, y: 0)
        }
        .padding(.horizontal, 16)
        .padding(.top, 16)
        .task(id: viewModel.character.id, priority: .userInitiated) {
            await viewModel.getCharacter()
        }
        .alert(isPresented: $viewModel.showErrorAlert) {
            Alert(
                title: Text("Network error"),
                message: Text("There was an error while trying to get character details"),
                dismissButton: .default(Text("OK"))
            )

        }
        .background(Color.backgroundsPrimary)
    }
}


#Preview {
    CharacterDetailsView(
        viewModel: .init(
            clients: .init(characterClient: .demo, databaseClient: .demo),
            characterId: 1
        )
    )
}
