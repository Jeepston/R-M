//
//  ParagraphSmallText.swift
//  rm
//
//  Created by Dmitrij Hojkolov on 16.10.2024.
//

import SwiftUI

struct ParagraphSmallText: View {

    private let text: String

    init(_ text: String) {
        self.text = text
    }

    var body: Text {
        Text(text)
            .font(.system(size: 14))
    }
}

#Preview {
    ParagraphSmallText("Small paragraph")
}
