//
//  ContentView.swift
//  Controller
//
//  Created by Andreas Gerono on 04/05/2021.
//  Copyright © 2021 Andreas Gerono. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: LedViewModel
    @State var showColorsView = false
    @State var selectedLed: LedController.Led?
    var body: some View {
        Grid(viewModel.leds) { led in
            LedView(led: led)
                .onTapGesture {
                    selectedLed = led
                    print(led, selectedLed!)
                    self.showColorsView.toggle()
                }
                .onLongPressGesture { viewModel.holdLed(led: led) }
        }
        .padding()
        .sheet(isPresented: $showColorsView) {
            ColorsSheet(viewModel: viewModel, selectedLed: $selectedLed, showColorsView: $showColorsView)
        }
    }
}

struct LedView: View {
    var led: LedController.Led
    var opacity: Double {led.isOn ? opaque : transparent}
    var text_color: Color = Color.black     // For white or black font dependent of color.
    var body: some View {
        GeometryReader { geometry in
            body(for: geometry.size)
        }
    }
    
    func body(for size: CGSize) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius).fill(Color(led.color))
            Text("Led: \(led.id+1)").foregroundColor(text_color)
        }
        .opacity(opacity)
        .font(Font.system(size: fontSize(for: size)))
        .padding(ledPadding)

    }
    
    // MARK: - LedView Drowing Constants
    let ledPadding: CGFloat = 3
    let cornerRadius: CGFloat = 10
    let opaque: Double = 1.0
    let transparent: Double = 0.3
    
    func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.2
    }
    
}

struct ColorsSheet: View {
    var viewModel: LedViewModel
    @Binding var selectedLed:LedController.Led?
    @Binding var showColorsView: Bool
    var colors = [UIColor.random, UIColor.random, UIColor.random, UIColor.random, UIColor.random, UIColor.random, UIColor.random, UIColor.random,
                  UIColor.random, UIColor.random, UIColor.random, UIColor.random, UIColor.random, UIColor.random, UIColor.random, UIColor.random,
                  UIColor.random, UIColor.random, UIColor.random, UIColor.random, UIColor.random, UIColor.random, UIColor.random, UIColor.random]

    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                VStack {
                    Spacer(minLength: spacerSize(for: geometry.size))
                    Grid(colors) { color in
                        Rectangle().fill(Color(color)).onTapGesture {
                            self.showColorsView = false
                            viewModel.changeColor(of: selectedLed!, to: color)
                        }
                    }
                    Spacer(minLength: spacerSize(for: geometry.size))
                }
                .navigationBarTitle("Select color")
                .navigationBarItems(trailing: Button(action: { self.showColorsView = false }, label: Text("Done").bold))
            }
        }
    }
    
    // MARK: - ColorsSheet Drawing Constants
    func spacerSize(for size: CGSize) -> CGFloat {
        size.height*0.1
    }
    

    
}

extension UIColor: Identifiable {
    class var random: UIColor {
        return UIColor(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1.0)
    }
}















struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: LedViewModel())
    }
}
