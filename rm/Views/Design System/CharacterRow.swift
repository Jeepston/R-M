//
//  CharacterRow.swift
//  rm
//
//  Created by Dmitrij Hojkolov on 16.10.2024.
//

import CachedAsyncImage
import SwiftUI

struct CharacterRow: View {

    // MARK: - View Object

    struct ViewObject {
        let imageUrl: URL?
        let name: String
        let status: String
        let isFavorite: Bool
    }


    // MARK: - Properties

    let viewObject: ViewObject

    private let imageSize = 44.0

    // MARK: - Body

    var body: some View {
        HStack{
            HStack(alignment: .top, spacing: 16) {
                CachedAsyncImage(url: viewObject.imageUrl, urlCache: .imageCache) { image in
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

                VStack(alignment: .leading, spacing: 2) {
                    HStack(spacing: 4) {
                        Headline3Text(viewObject.name)
                            .lineLimit(2)

                        if viewObject.isFavorite {
                            Image(.favFull)
                                .resizable()
                                .scaledToFit()
                                .frame(size: 16)
                                .foregroundStyle(Color.accent)
                        }
                    }

                    ParagraphSmallText(viewObject.status)
                        .foregroundColor(Color.foregroundsSecondary)

                }
            }

            Spacer()

            Image(systemName: "chevron.forward")
                .resizable()
                .scaledToFit()
                .frame(size: 14)
                .foregroundStyle(Color.iconsSecondary)
                .padding(10)
        }
        .padding(.leading, 8)
        .frame(height: 60)
        .background(Color.cardBackground)
        .cornerRadius(16)
        .shadow(color: .cardShadow, radius: 16, x: 0, y: 0)
    }
}


// MARK: - Preview

#Preview {
    @ViewBuilder
    var contentPreview: AnyView {
        AnyView(
            VStack {
                CharacterRow(
                    viewObject: .init(
                        imageUrl: URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg"),
                        name: "Rick Sanchez",
                        status: "Alive",
                        isFavorite: false
                    )
                )
                .padding()

                CharacterRow(
                    viewObject: .init(
                        imageUrl: URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg"),
                        name: "Rick Sanchez",
                        status: "Alive",
                        isFavorite: true
                    )
                )
                .padding()
            }
        )
    }

    VStack {
        contentPreview
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        contentPreview
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black)
            .environment(\.colorScheme, .dark)
    }
}
