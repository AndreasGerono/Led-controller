//
//  ThemesViewModel.swift
//  Controller
//
//  Created by Andreas Gerono on 24/05/2021.
//  Copyright © 2021 Andreas Gerono. All rights reserved.
//

import SwiftUI

class ThemesViewModel: ObservableObject {
    @Published private var model: ThemeStore = ThemeStore()
    
    // MARK: - Access to the model
    
    var themes: [ThemeStore.Theme] {
        return model.themes
    }
    
    // MARK: - Intent(s)
    
    func edit(theme: ThemeStore.Theme, name: String, colors: [UIColor]) {
        model.updateTheme(theme, newName: name, newColors: colors)
    }
    
    func addTheme(name: String, colors: [UIColor]) {
        model.addTheme(name: name, colors: colors)
    }
    
    func delete(theme: ThemeStore.Theme) {
        model.deleteTheme(theme)
    }
    
}
