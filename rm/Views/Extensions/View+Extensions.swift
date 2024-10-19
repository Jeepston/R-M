//
//  View+Extensions.swift
//  rm
//
//  Created by Dmitrij Hojkolov on 16.10.2024.
//

import SwiftUI

extension View {
    @ViewBuilder
    func shimmer(when isLoading: Binding<Bool> = .constant(true)) -> some View {
        if isLoading.wrappedValue {
            self.modifier(Shimmer())
                .redacted(reason: isLoading.wrappedValue ? .placeholder : [])
        } else {
            self
        }
    }

    func frame(size: CGFloat) -> some View {
        self
            .frame(width: size, height: size)
    }
}

struct Shimmer: ViewModifier {
    @State private var isInitialState = true

    public func body(content: Content) -> some View {
        content
            .mask(
                LinearGradient(
                    gradient: .init(colors: [.black.opacity(0.4), .black, .black.opacity(0.4)]),
                    startPoint: (isInitialState ? .init(x: -0.3, y: -0.3) : .init(x: 1, y: 1)),
                    endPoint: (isInitialState ? .init(x: 0, y: 0) : .init(x: 1.3, y: 1.3))
                )
            )
            .animation(.linear(duration: 1.5).delay(0.25).repeatForever(autoreverses: false), value: isInitialState)
            .onAppear {
                isInitialState = false
            }
    }
}
