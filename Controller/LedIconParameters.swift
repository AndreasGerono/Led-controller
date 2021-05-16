//
//  LedIconParameters.swift
//  Controller
//
//  Created by Andreas Gerono on 11/05/2021.
//  Copyright © 2021 Andreas Gerono. All rights reserved.
//

import CoreGraphics

struct LedLensParameters {
    struct Segment {
        let line: CGPoint
        let curve: CGPoint
        let control1: CGPoint
        let control2: CGPoint
    }
    
    static let adjustment: CGFloat = 0.085
    
    static let segments = [
        Segment(
            line: CGPoint(x: 0.64, y: 0.5),
            curve: CGPoint(x: 0.64, y: 0.5),
            control1: CGPoint(x: 0.64, y: 0.5),
            control2: CGPoint(x: 0.64, y: 0.5)
        ),
        Segment(
            line: CGPoint(x: 0.64, y: 0.45),
            curve: CGPoint(x: 0.64, y: 0.45),
            control1: CGPoint(x: 0.64, y: 0.45),
            control2: CGPoint(x: 0.64, y: 0.45)
        ),
        Segment(
            line: CGPoint(x: 0.61, y: 0.45),
            curve: CGPoint(x: 0.61, y: 0.45),
            control1: CGPoint(x: 0.61, y: 0.45),
            control2: CGPoint(x: 0.61, y: 0.45)
        ),
        Segment(
            line: CGPoint(x: 0.61, y: 0.22),
            curve: CGPoint(x: 0.61, y: 0.22),
            control1: CGPoint(x: 0.61, y: 0.22),
            control2: CGPoint(x: 0.61, y: 0.22)
        ),
        Segment(
            line: CGPoint(x: 0.61, y: 0.22),
            curve: CGPoint(x: 0.39, y: 0.22),
            control1: CGPoint(x: 0.61, y: 0.08),
            control2: CGPoint(x: 0.39, y: 0.08)
        ),
        Segment(
            line: CGPoint(x: 0.39, y: 0.45),
            curve: CGPoint(x: 0.39, y: 0.45),
            control1: CGPoint(x: 0.39, y: 0.45),
            control2: CGPoint(x: 0.39, y: 0.45)
        ),
        Segment(
            line: CGPoint(x: 0.36, y: 0.45),
            curve: CGPoint(x: 0.36, y: 0.45),
            control1: CGPoint(x: 0.36, y: 0.45),
            control2: CGPoint(x: 0.36, y: 0.45)
        ),
        Segment(
            line: CGPoint(x: 0.36, y: 0.5),
            curve: CGPoint(x: 0.36, y: 0.5),
            control1: CGPoint(x: 0.36, y: 0.5),
            control2: CGPoint(x: 0.36, y: 0.5)
        ),
        Segment(
            line: CGPoint(x: 0.5, y: 0.5),
            curve: CGPoint(x: 0.5, y: 0.5),
            control1: CGPoint(x: 0.5, y: 0.5),
            control2: CGPoint(x: 0.5, y: 0.5)
        ),
    ]
    
    static func start(in rect: CGRect) -> CGPoint {
        CGPoint(x: 0.5 * rect.width, y: 0.5 * rect.height)
    }
}


struct LedLegsParameters {
    var offset: CGFloat
    var len_adjustment: CGFloat
    var segments: [CGPoint]
    
    init(is_right: Bool) {
        offset = is_right ? 1.0 : -1.0
        len_adjustment =  is_right ? 0.92 : 0.8
        segments = [
            CGPoint(x: 0.5 + 0.05 * offset, y: 1.0 * len_adjustment),
            CGPoint(x: 0.5 + 0.031 * offset, y: 1.0 * len_adjustment),
            CGPoint(x: 0.5 + 0.031 * offset, y: 0.5),
        ]
    }
    
    func start(in rect: CGRect) -> CGPoint {
        CGPoint(x: (0.5 + 0.05 * offset) * rect.width, y: 0.5 * rect.height)
    }
}


struct LedParameters {
    static let adjustment: CGFloat = 0.085
    static let cathode_start = CGPoint(x: 0.555, y: 0.45)
    static let anode_start =  CGPoint(x: 0.44, y: 0.45)
    
    static let cathode: [CGPoint] = [
        CGPoint(x: 0.555, y: 0.33),
        CGPoint(x: 0.44, y: 0.33),
        CGPoint(x: 0.49, y: 0.37),
        CGPoint(x: 0.535, y: 0.37),
        CGPoint(x: 0.535, y: 0.45),
    ]
    
    static let anode: [CGPoint] = [
        CGPoint(x: 0.44, y: 0.34),
        CGPoint(x: 0.48, y: 0.375),
        CGPoint(x: 0.48, y: 0.45),
    ]

    static func cathode_start(in rect: CGRect) -> CGPoint {
        CGPoint(x: cathode_start.x * rect.width, y: cathode_start.y * rect.height)
    }
    static func anode_start(in rect: CGRect) -> CGPoint {
        CGPoint(x: anode_start.x * rect.width, y: anode_start.y * rect.height)
    }
}
