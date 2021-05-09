//
//  LedController.swift
//  Controller
//
//  Created by Andreas Gerono on 04/05/2021.
//  Copyright © 2021 Andreas Gerono. All rights reserved.
//

import Foundation
import SwiftUI

struct LedController {
    var leds: Array<Led>
    var isConnected: Bool = false
    
    mutating func toogleLed(led: Led) {
        if let i = leds.firstIndex(where: {$0.id == led.id} ) {
            leds[i].isOn = !leds[i].isOn
            print("Led toogled \(leds[i])")
        }
    }
    
    mutating func updateColor(of led: Led, to color: UIColor) {
        if let i = leds.firstIndex(where: {$0.id == led.id} ) {
            leds[i].color = color
            print("Led color changed! \(leds[i])")
        }
    }
    
    init(no_leds: Int, ledFactory: (Int) -> (UIColor, Bool)) {
        leds = Array<Led>()
        for index in 0..<no_leds {
            let color_state = ledFactory(index)
            leds.append(Led(color: color_state.0, isOn: color_state.1, id: index))
        }
    }
    
    struct Led: Identifiable {
        var color: UIColor
        var isOn: Bool
        var id: Int
    }
}
