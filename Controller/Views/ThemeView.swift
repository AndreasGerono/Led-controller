//
//  ThemeView.swift
//  Controller
//
//  Created by Andreas Gerono on 20/05/2021.
//  Copyright © 2021 Andreas Gerono. All rights reserved.
//

import SwiftUI


struct ThemeView: View {
    @EnvironmentObject var store: ThemesViewModel
    
    @State private var showEditView = false
    @State private var selectedTheme: ThemeStore.Theme?
    
    @Environment(\.editMode) private var editMode
    
    var body: some View {
        VStack {
            List {
                ForEach(store.themes) { theme in
                    Theme(colors: theme.colors, title: theme.name)
                        .onTapGesture {
                            if (editMode!.wrappedValue == .active) {
                                print("edit theme!")
                                selectedTheme = theme
                                showEditView.toggle()
                            } else {
                            print("load theme!")
                        }
                    }
                }
                .onDelete(perform: delete)
            }
            addButton(showEditView: $showEditView)
                .navigationBarTitle("color themes", displayMode: .large)
                .navigationBarItems(trailing: EditButton())
        }
        .sheet(isPresented: $showEditView) {
            EditTheme(showEditView: $showEditView, selected: $selectedTheme)
        }
    }
        
    func delete(at index: IndexSet) {
        print("Deleted! \(index)")
        for i in index {
            print("i")
            store.delete(theme: store.themes[i])
        }
    }
    
}

struct addButton: View {
    @Environment(\.editMode) private var editMode
    @Binding var showEditView: Bool
    @ViewBuilder
    var body: some View {
        if (editMode!.wrappedValue == .active) {
            Button(action: { showEditView.toggle() }) {
                Image(systemName: "plus.circle.fill").font(Font.system(.largeTitle))
            }
        }
        EmptyView()
    }
}


struct EditTheme: View {
    @EnvironmentObject var store: ThemesViewModel
    
    @Binding var showEditView: Bool
    @Binding var selected: ThemeStore.Theme?
    
    @State private var showColorsView = false
    @State private var sheetTitle = "Select color"
    @State private var selectedColorIndex: Int?

    @State var themename: String
    @State var colors = [UIColor?]()
    var title: String
    
    init(showEditView: Binding<Bool>, selected: Binding<ThemeStore.Theme?>) {
        self._showEditView = showEditView
        self._selected = selected
        
        self.themename = selected.wrappedValue?.name ?? ""
        self.colors = selected.wrappedValue?.colors ?? [UIColor?](repeating: nil, count: 16)
        title = selected.wrappedValue == nil ? "Add theme" : "Edit theme"
    }
    
    var threeRowGrid = [GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                Form {
                    Section {
                        TextField("Theme name:", text: $themename)
                    }
                    Section(header: Text("Theme colors:")) {
                        LazyHGrid(rows: threeRowGrid) {
                            ForEach(colors.indices) { i in
                                ZStack {
                                    Circle().fill(Color(colors[i] ?? defaultColor)).frame(width: circleSize(for: geometry.size), height: circleSize(for: geometry.size), alignment: .center)
                                    
                                    Circle().stroke(lineWidth: circleLine).frame(width: circleSize(for: geometry.size), height: circleSize(for: geometry.size), alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    
                                }
                                .onTapGesture {
                                    selectedColorIndex = i
                                    showColorsView.toggle()
                                    sheetTitle = "Select color \(i + 1)"
                                    print("Add color")
                                }
                            }
                        }
                        .frame(width: gridWidth(for: geometry.size), height: gridHeight(for: geometry.size), alignment: .center)
                    }
                }
                .navigationBarTitle(title)
                .navigationBarItems(
                    leading: Button(
                        action: {showEditView.toggle()},
                        label: {Text("Cancel")}),
                    trailing: Button(
                        action: {
                            showEditView.toggle()
                            if let theme = selected {
                                store.edit(theme: theme, name: themename, colors: colors.map({$0!}))
                            } else {
                                store.addTheme(name: themename, colors: colors.map({$0!}))
                            }
                        },
                        label: {
                            Text("Save")
                        }).disabled(formIsVatid ? false : true)
                )
                
            }
            
        }
 
        .onDisappear(perform: {
            print("disapear!")
            selected = nil
        })
        .sheet(isPresented: $showColorsView) {
            ColorsSheet(showColorsView: $showColorsView, sheetTitle: $sheetTitle) { color in
                colors[selectedColorIndex!] = color
            }
        }
    }
    
    var formIsVatid: Bool {
        return !self.themename.isEmpty && !self.colors.contains(nil)
    }
    
    func gridWidth(for size: CGSize) -> CGFloat {
        size.width * 0.8
    }
    
    func gridHeight(for size: CGSize) -> CGFloat {
        size.width * 0.35
    }
    
    func circleSize(for size: CGSize) -> CGFloat {
        size.width * 0.08
    }
    
    // MARK: - Theme Drawing Constants
    let colorSize: CGFloat = 40
    let circleLine: CGFloat = 2
    let defaultColor: UIColor = UIColor(white: 1, alpha: 0.01)
}

struct Theme: View {
    var colors: [UIColor]
    var title: String
    @State private var colorsPrefix: [UIColor]
    init(colors: [UIColor], title: String) {
        self.colors = colors
        self.title = title
        self.colorsPrefix = UIDevice.current.orientation.isLandscape ? colors : Array(colors.prefix(maxColors))
    }
    var body: some View {
        VStack(alignment: .leading) {
            Text("Theme \(title)").font(.title2)
            HStack {
                ForEach(colorsPrefix) { color in
                    Circle()
                        .fill(Color(color))
                        .frame(width: colorSize, height: colorSize, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }
                if colorsPrefix.count <= maxColors {
                    Image(systemName: "ellipsis")
                }
            }
        }
        .onRotate { newOrientation in
            self.colorsPrefix = newOrientation.isLandscape ? colors : Array(colors.prefix(maxColors))
        }
    }
    
    // MARK: - Theme Drawing Constants
    let colorSize: CGFloat = 30
    let maxColors: Int = 8

}




struct ThemeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ThemeView()
//            ContentView(viewModel: LedViewModel())
//                .previewLayout(
//                    PreviewLayout.fixed(
//                        width: 1792.0,
//                        height: 828.0
//                    ))
        }
    }
}
