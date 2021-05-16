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
    
    private func body(for size: CGSize) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
            RoundedRectangle(cornerRadius: cornerRadius).stroke(Color.blue, lineWidth: 4).opacity(opacity)
            LedIcon(led_color: Color(led.color))
        }
        .font(Font.system(size: fontSize(for: size)))
        .padding(ledPadding)

    }
    
    // MARK: - LedView Drowing Constants
    private let ledPadding: CGFloat = 5
    private let cornerRadius: CGFloat = 10
    private let opaque: Double = 1.0
    private let transparent: Double = 0.3
    private let frame_scale: CGFloat = 0.8
    
    func frameSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * frame_scale
    }
    
    func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.1
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
                    Grid(colors) { color in body(for: color) }
                    Spacer(minLength: spacerSize(for: geometry.size))
                }
                .navigationBarTitle("Select color for led \(selectedLed!.id + 1)")
                .navigationBarItems(trailing: Button(action: { showColorsView = false }, label: Text("Done").bold))
            }
        }
    }
    
    private func body(for color: UIColor) -> some View {
        Rectangle().fill(Color(color)).onTapGesture {
            showColorsView = false
            viewModel.changeColor(of: selectedLed!, to: color)
        }
    }
    
    // MARK: - ColorsSheet Drawing Constants
    private func spacerSize(for size: CGSize) -> CGFloat {
        size.height*0.1
    }
}










struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: LedViewModel())
    }
}
