//
//  ThemeView.swift
//  Controller
//
//  Created by Andreas Gerono on 20/05/2021.
//  Copyright © 2021 Andreas Gerono. All rights reserved.
//

import SwiftUI


struct ThemeView: View {
    private var tmpColors = [UIColor.random, UIColor.random, UIColor.random, UIColor.random, UIColor.random, UIColor.random, UIColor.random, UIColor.random]
    private var theme_names = ["test1", "test2", "test3", "test4", "test5"]
    
    @State private var showEditView = false
    @Environment(\.editMode) private var editMode
    
    var body: some View {
        VStack {
            List {
                ForEach(theme_names, id: \.self) { name in
                    Theme(colors: tmpColors, title: name)
                }
                .onDelete(perform: delete)
            }
            addButton(showEditView: $showEditView)
                .navigationBarTitle("color themes", displayMode: .large)
                .navigationBarItems(trailing: EditButton())
        }
        .sheet(isPresented: $showEditView) {
            EditTheme(showEditView: $showEditView)
        }
    }
        
    
    func delete(at index: IndexSet) {
        print("Deleted! \(index)")
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
    @Binding var showEditView: Bool
    @State private var showColorsView = false
    @State private var sheetTitle = "Select color"
    @State private var selectedColorIndex: Int?

    @State var themename: String = ""
    @State var colors = [UIColor?](repeating: nil, count: 16)
    
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
                            ForEach(0..<colors.count) { index in
                                ZStack {
                                    Circle().fill(Color(colors[index] ?? UIColor.init(white: 1, alpha: 0.1))).frame(width: circleSize(for: geometry.size), height: circleSize(for: geometry.size), alignment: .center)
                                    
                                    Circle().stroke(lineWidth: circleLine).frame(width: circleSize(for: geometry.size), height: circleSize(for: geometry.size), alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    
                                }
                                .onTapGesture {
                                    selectedColorIndex = index
                                    showColorsView.toggle()
                                    sheetTitle = "Select color \(index + 1)"
                                    print("Add color")
                                }
                            }
                        }
                        .frame(width: gridWidth(for: geometry.size), height: gridHeight(for: geometry.size), alignment: .center)
                    }
                }
                .navigationBarTitle("Add theme")
                .navigationBarItems(
                    leading: Button(action: {showEditView.toggle()}, label: {Text("Cancel")}),
                    trailing: Button(action: {showEditView.toggle()}, label: {Text("Done")})
                )
            }
        }
        .sheet(isPresented: $showColorsView) {
            ColorsSheet(showColorsView: $showColorsView, sheetTitle: $sheetTitle) { color in
                colors[selectedColorIndex!] = color
            }
        }
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
}

struct Theme: View {
    var colors: [UIColor]
    var title: String
    var body: some View {
        VStack(alignment: .leading) {
            Text("Theme \(title)").font(.title2)
            HStack {
                ForEach(colors) { color in
                    Circle()
                        .fill(Color(color))
                        .frame(width: colorSize, height: colorSize, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }
                Text("...").font(.body)
            }
        }
    }
    
    // MARK: - Theme Drawing Constants
    let colorSize: CGFloat = 30

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
