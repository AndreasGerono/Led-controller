//
//  LedViewModel.swift
//  Controller
//
//  Created by Andreas Gerono on 04/05/2021.
//  Copyright © 2021 Andreas Gerono. All rights reserved.
//

import SwiftUI

class LedViewModel {
    private var model: LedController = LedViewModel.createLedController()
    
    // Cant use struct functions before init! So static function... -> class function not object.
    static func createLedController() -> LedController {
        let led_colors: Array<LedController.LedColor> = [LedController.LedColor(red: 10, green: 10, blue: 128),
                                                         LedController.LedColor(red: 128, green: 10, blue: 10),
                                                         LedController.LedColor(red: 10, green: 128, blue: 10)]
        
        return LedController(no_leds: 3) { index in led_colors[index] }
    }
    
    // MARK: - Access to the model
    
    var leds: Array<LedController.Led> {    // Here you can make modifications, so the led are better suited for view?
        return model.leds
    }
    
    
    // MARK: - Intent(s)
    
    func tapLed(led: LedController.Led) {
        model.chooseLed(led: led)
    }
    
    func holdLed(led: LedController.Led) {
        model.toogleLed(led: led)
    }
}
