//
//  rmApp.swift
//  rm
//
//  Created by Dmitrij Hojkolov on 15.10.2024.
//

import SwiftUI
import SwiftData


@main
struct rmApp: App {

    init() {
        setUpAppearance()
    }

    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }

    private func setUpAppearance() {
        let searchBarAppearance = UISearchBar.appearance()

        searchBarAppearance.tintColor = UIColor.searchBarTint
        searchBarAppearance.setImage(UIImage(named: "search"), for: .search, state: .normal)
        // Horizontal offset is an empirical value to make it look as close as possible to the design in Figma.
        // Not possible to set exact value due to internal offsets / paddings
        searchBarAppearance.setPositionAdjustment(UIOffset(horizontal: 4, vertical: 0), for: .search)

        searchBarAppearance.setImage(UIImage(named: "x-circle"), for: .clear, state: .normal)

        let searchTextFieldAppearance = UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self])
        searchTextFieldAppearance.font = .systemFont(ofSize: 16)
        searchTextFieldAppearance.leftView?.tintColor = UIColor.searchIcon
    }
}
