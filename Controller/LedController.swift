//
//  LedController.swift
//  Controller
//
//  Created by Andreas Gerono on 04/05/2021.
//  Copyright © 2021 Andreas Gerono. All rights reserved.
//

import Foundation

struct LedController {
    var leds: Array<Led>
    var isConnected: Bool = false
    
    func toogleLed(led: Led) {
        print("Led toogled \(led)")
    }
    
    func chooseLed(led: Led) {
        print("Led choosen \(led)")
    }
    
    init(no_leds: Int, ledFactory: (Int) -> LedColor) {
        leds = Array<Led>()
        for index in 0..<no_leds {
            let led_color = ledFactory(index)
            leds.append(Led(color: led_color, isOn: false, index: index))
        }
    }
    
    struct LedColor {
        var red: Int
        var green: Int
        var blue: Int
    }
    
    struct Led {
        var color: LedColor
        var isOn: Bool
        var index: Int
    }
}
