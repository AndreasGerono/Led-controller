//
//  ContentView.swift
//  Controller
//
//  Created by Andreas Gerono on 04/05/2021.
//  Copyright © 2021 Andreas Gerono. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            HStack {
                LedView(led_isOn: true, led_color: Color.red, led_index: 16)
                LedView(led_isOn: true, led_color: Color.green, led_index: 15)
            }
            HStack {
                LedView(led_isOn: true, led_color: Color.red, led_index: 14)
                LedView(led_isOn: true, led_color: Color.green, led_index: 12)
            }
            HStack {
                LedView(led_isOn: true, led_color: Color.blue, led_index: 12)
                LedView(led_isOn: false, led_color: Color.yellow, led_index: 11)
            }
            HStack {
                LedView(led_isOn: false, led_color: Color.orange, led_index: 9)
                LedView(led_isOn: false, led_color: Color.pink, led_index: 8)
            }
            HStack {
                LedView(led_isOn: false, led_color: Color.orange, led_index: 7)
                LedView(led_isOn: false, led_color: Color.pink, led_index: 6)
            }
            HStack {
                LedView(led_isOn: false, led_color: Color.orange, led_index: 5)
                LedView(led_isOn: false, led_color: Color.pink, led_index: 4)
            }
            HStack {
                LedView(led_isOn: false, led_color: Color.orange, led_index: 3)
                LedView(led_isOn: false, led_color: Color.pink, led_index: 2)
            }
            HStack {
                LedView(led_isOn: false, led_color: Color.pink, led_index: 1)
                LedView(led_isOn: true, led_color: Color.yellow, led_index: 10)
            }

        }
        .padding()
    }
}



struct LedView: View {
    var led_isOn: Bool
    var led_color: Color
    var led_index: Int
    var opacity: Double {led_isOn ? 1 : 0.3}
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 10).fill(led_color)
            Text("Led: \(led_index)")
        }
        .opacity(opacity)
    }
}





















struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
