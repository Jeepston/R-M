//
//  CharacterDetailStatusRow.swift
//  rm
//
//  Created by Dmitrij Hojkolov on 16.10.2024.
//

import SwiftUI

struct CharacterDetailStatusRow: View {

    // MARK: - Properties

    let label: String
    let value: String

    // MARK: - Body

    var body: some View {
        HStack {
            ParagraphSmallText(label)
                .foregroundStyle(Color.foregroundsSecondary)
                .frame(width: 100, alignment: .leading)

            Headline3Text(value.isEmpty ? "-" : value)

            Spacer()
        }
    }
}

// MARK: - Preview

#Preview {
    CharacterDetailStatusRow(label: "Location", value: "-")
}
