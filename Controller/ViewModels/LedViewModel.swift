//
//  LedViewModel.swift
//  Controller
//
//  Created by Andreas Gerono on 04/05/2021.
//  Copyright © 2021 Andreas Gerono. All rights reserved.
//

import SwiftUI

class LedViewModel: ObservableObject {
    // This is a property wrapper -> Aka magic variable, wrapper
    @Published private var model: LedController = LedViewModel.createLedController()
    
    // Can't use struct functions before init! So static function... -> class function not object.
    private static func createLedController() -> LedController {
        let colors_states: Array<(UIColor, Bool)> = [(UIColor.green, false),
                                                     (UIColor.red, true),
                                                     (UIColor.cyan, true),
                                                     (UIColor.purple, false),
                                                     (UIColor.blue, false),
                                                     (UIColor.yellow, false),
                                                     (UIColor.systemPink, false),
                                                     (UIColor.magenta, false)]
        
        return LedController(no_leds: colors_states.count) { colors_states[$0] }
    }
    
    // MARK: - Access to the model
    
    var leds: Array<LedController.Led> {    // Here you can make modifications, so the led are better suited for view?
        return model.leds
    }
    
    
    // MARK: - Intent(s)
        
    func changeColor(of led: LedController.Led, to color: UIColor) {
        model.updateColor(of: led, to: color)
    }
    
    func holdLed(led: LedController.Led) {
        model.toogleLed(led: led)
    }
}
