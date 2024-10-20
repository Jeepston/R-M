//
//  ParagraphSmallText.swift
//  rm
//
//  Created by Dmitrij Hojkolov on 16.10.2024.
//

import SwiftUI

struct ParagraphMediumText: View {

    // MARK: - Properties

    private let text: String

    init(_ text: String) {
        self.text = text
    }

    // MARK: - Body

    var body: Text {
        Text(text)
            .font(.system(size: 16))
    }
}

// MARK: - Preview

#Preview {
    ParagraphSmallText("Medium paragraph")
}
