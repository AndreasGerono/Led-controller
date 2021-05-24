//
//  themeStore.swift
//  Controller
//
//  Created by Andreas Gerono on 24/05/2021.
//  Copyright © 2021 Andreas Gerono. All rights reserved.
//

import Foundation
import SwiftUI

struct ThemeStore {
    private(set) var themes: [Theme]
    
    mutating func updateTheme(_ theme: Theme, newName: String, newColors: [UIColor]) {
        if let i = themes.firstIndex(where: {$0.id == theme.id}) {
            themes[i].colors = newColors
            themes[i].name = newName
        }
    }
    
    mutating func addTheme(name: String, colors: [UIColor]) {
        let id = themes.count + 1
        themes.append(
            Theme(id: id, name: name, colors: colors)
        )
    }
    
    mutating func deleteTheme(_ theme: Theme) {
        if let i = themes.firstIndex(where: {$0.id == theme.id}) {
            themes.remove(at: i)
        }
    }
    
    init() {
        themes = [Theme]()  // Always start empty
    }
    
    struct Theme: Identifiable {
        var id: Int
        var name: String
        var colors: [UIColor]
    }
}
