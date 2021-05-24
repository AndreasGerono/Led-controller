//
//  ColorsSheet.swift
//  Controller
//
//  Created by Andreas Gerono on 23/05/2021.
//  Copyright © 2021 Andreas Gerono. All rights reserved.
//

import SwiftUI

struct ColorsSheet: View {
    @Binding var showColorsView: Bool
    @Binding var sheetTitle: String
    
    var onTapFunc: (UIColor) -> Void
    var colors = [UIColor.random, UIColor.random, UIColor.random, UIColor.random, UIColor.random, UIColor.random, UIColor.random, UIColor.random,
                  UIColor.random, UIColor.random, UIColor.random, UIColor.random, UIColor.random, UIColor.random, UIColor.random, UIColor.random,
                  UIColor.random, UIColor.random, UIColor.random, UIColor.random, UIColor.random, UIColor.random, UIColor.random, UIColor.random]
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                VStack {
                    Spacer(minLength: spacerSize(for: geometry.size))
                    Grid(colors) { color in body(for: color) }
                    Spacer(minLength: spacerSize(for: geometry.size))
                }
                .navigationBarTitle(sheetTitle)
                .navigationBarItems(trailing: Button(action: { showColorsView.toggle() }, label: Text("Done").bold))
            }
        }
    }
    
    private func body(for color: UIColor) -> some View {
        Rectangle().fill(Color(color)).onTapGesture {
            showColorsView = false
            onTapFunc(color)
        }
    }
    
    // MARK: - ColorsSheet Drawing Constants
    private func spacerSize(for size: CGSize) -> CGFloat {
        size.height*0.1
    }
}


