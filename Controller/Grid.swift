//
//  Grid.swift
//  Controller
//
//  Created by Andreas Gerono on 07/05/2021.
//  Copyright © 2021 Andreas Gerono. All rights reserved.
//

import SwiftUI

struct Grid<Item, ItemView>: View where Item: Identifiable, ItemView: View {    //Item has to be a type of identifiable, ItemView has to be a View!
    private var items: [Item]
    private var viewForItem: (Item) -> ItemView
    
    init(_ items: [Item], viewForItem: @escaping (Item) -> ItemView) {  // Function will escape from initializer? Will be called later than initializer?
        self.items = items
        self.viewForItem = viewForItem
    }
    
    var body: some View {
        GeometryReader { geometry in
            body(in: GridLayout(itemCount: items.count, in: geometry.size))
        }
    }
    
    
    func body(in layout: GridLayout) -> some View {
        ForEach(0..<items.count) { i in
            viewForItem(items[i])
                .frame(width: layout.itemSize.width, height: layout.itemSize.height)
                .position(layout.location(ofItemAt: i))
        }
    }
}

