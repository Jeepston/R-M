//
//  Headline3Text.swift
//  rm
//
//  Created by Dmitrij Hojkolov on 16.10.2024.
//

import SwiftUI

struct Headline1Text: View {

    private let text: String

    init(_ text: String) {
        self.text = text
    }

    var body: Text {
        Text(text)
            .font(.system(size: 28, weight: .bold))
            .foregroundStyle(Color.primary)
    }
}

#Preview {
    Headline1Text("Headline1")
}
