//
//  ParagraphSmallText.swift
//  rm
//
//  Created by Dmitrij Hojkolov on 16.10.2024.
//

import SwiftUI

struct ParagraphMediumText: View {

    private let text: String

    init(_ text: String) {
        self.text = text
    }

    var body: Text {
        Text(text)
            .font(.system(size: 16))
    }
}

#Preview {
    ParagraphSmallText("Medium paragraph")
}
