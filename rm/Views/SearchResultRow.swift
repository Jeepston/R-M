//
//  SearchResultRow.swift
//  rm
//
//  Created by Dmitrij Hojkolov on 19.10.2024.
//

import SwiftUI

struct SearchResultRow: View {

    // MARK: - View Object

    struct ViewObject {
        let imageUrl: URL?
        let name: String
        let status: String
    }

    // MARK: - Properties

    let viewObject: ViewObject

    private let imageSize = 44.0

    // MARK: - Body

    var body: some View {
        HStack {
            HStack(alignment: .top, spacing: 16) {
                AsyncImage(url: viewObject.imageUrl) { image in
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
                    Headline3Text(viewObject.name)
                        .lineLimit(2)

                    ParagraphSmallText(viewObject.status)
                        .foregroundColor(Color.foregroundsSecondary)

                }
            }

            Spacer()
        }
        .padding(.leading, 8)
        .frame(height: 60)
    }
}

// MARK: - Preview

#Preview {
    @ViewBuilder
    var contentPreview: AnyView {
        AnyView(
            SearchResultRow(
                viewObject: .init(
                    imageUrl: URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg"),
                    name: "Rick Sanchez",
                    status: "Alive"
                )
            )
            .padding()
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
