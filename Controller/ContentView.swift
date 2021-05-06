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
    var body: some View {
        HStack {
            ForEach(viewModel.leds) { led in
                LedView(led: led)
                    .onTapGesture {
                        self.viewModel.tapLed(led: led)
                }
                    .onLongPressGesture { self.viewModel.holdLed(led: led)}
                    .aspectRatio(1, contentMode: .fit)
            }
        }
        .padding()
    }
}

struct LedView: View {
    var led: LedController.Led
    var opacity: Double {led.isOn ? opaque : transparent}
    var text_color: Color = Color.black     // For white or black font dependent of color.
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    func body(for size: CGSize) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10).fill(Color(led.color))
            Text("Led: \(self.led.id+1)").foregroundColor(text_color)
        }
        .opacity(self.opacity)
        .font(Font.system(size: fontSize(for: size)))
    }
    
    // MARK: - Drowing Constants
    let cornerRadius: CGFloat = 10
    let opaque: Double = 1.0
    let transparent: Double = 0.3
    
    func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.2
    }
    
}





















struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: LedViewModel())
    }
}
