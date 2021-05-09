//
//  UIColor+Random+ID.swift
//  Controller
//
//  Created by Andreas Gerono on 09/05/2021.
//  Copyright © 2021 Andreas Gerono. All rights reserved.
//

import SwiftUI

extension UIColor: Identifiable {
    class var random: UIColor {
        return UIColor(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1.0)
    }
}
