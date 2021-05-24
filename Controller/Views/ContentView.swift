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
    @State private var showColorsView = false
    @State private var selectedLed: LedController.Led?
    @State private var sheetTitle: String = "Select color for led"
    
    var body: some View {
        NavigationView {
            Grid(viewModel.leds) { led in
                LedView(led: led)
                    .onTapGesture {
                        selectedLed = led
                        print(selectedLed!)
                        sheetTitle = "Select color for led \(selectedLed!.id + 1)"
                        self.showColorsView.toggle()
                    }
                    .onLongPressGesture {
                        withAnimation(.easeInOut) {
                            viewModel.holdLed(led: led)
                            simpleSuccess()
                        }
                    }
            }
            .padding()
            .sheet(isPresented: $showColorsView) {
                ColorsSheet(showColorsView: $showColorsView, sheetTitle: $sheetTitle) { color in
                    withAnimation(.easeInOut) {
                        viewModel.changeColor(of: selectedLed!, to: color)
                    }
                }
            }
            .navigationBarTitle("led controller", displayMode: .inline)
            .navigationBarItems(leading:
                                    Text("connect"),
                                trailing:
                                    NavigationLink(
                                        destination: ThemeView(),
                                        label: {Image(systemName: "star.fill").font(.title2)}
                                    )
            )
        }
    }
    
    
    func simpleSuccess() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
}

struct LedView: View {
    var led: LedController.Led
    var text_color: Color = Color.black
    var opacity: Double {led.isOn ? 1:  transparent}
    var body: some View {
        GeometryReader { geometry in
            body(for: geometry.size)
        }
    }
    
    private func body(for size: CGSize) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
            RoundedRectangle(cornerRadius: cornerRadius).stroke(Color.blue, lineWidth: 4)
                .opacity(opacity)
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













struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView(viewModel: LedViewModel())
//            ContentView(viewModel: LedViewModel())
//                .previewLayout(
//                    PreviewLayout.fixed(
//                        width: 1792.0,
//                        height: 828.0
//                    ))
        }
    }
}
