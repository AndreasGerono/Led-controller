//
//  LedShape.swift
//  Controller
//
//  Created by Andreas Gerono on 09/05/2021.
//  Copyright © 2021 Andreas Gerono. All rights reserved.
//

import SwiftUI


struct LedLegs: Shape {
    func path(in rect: CGRect) -> Path {
        let width = rect.width
        let height = rect.height
        var p = Path()
        
        let rigthLegParameters = LedLegsParameters(is_right: false)
        let leftLegParameters = LedLegsParameters(is_right: true)
        p.move(to: leftLegParameters.start(in: rect))
        leftLegParameters.segments.forEach { segment in
            p.addLine( to: CGPoint( x: width*segment.x, y: height*segment.y ))
        }
        p.move(to: rigthLegParameters.start(in: rect))
        rigthLegParameters.segments.forEach { segment in
            p.addLine( to: CGPoint( x: width*segment.x, y: height*segment.y ))
        }
        
        return p
    }
}


struct LedInternals: Shape {
    func path(in rect: CGRect) -> Path {
        let width = rect.width
        let height = rect.height
        var p = Path()
        p.move(to: LedParameters.anode_start(in: rect))
        LedParameters.anode.forEach { line in
            p.addLine( to: CGPoint( x: width*line.x, y: height*line.y ))
        }
        p.move(to: LedParameters.cathode_start(in: rect))
        LedParameters.cathode.forEach { line in
            p.addLine( to: CGPoint( x: width*line.x, y: height*line.y ))
        }        
        
        return p
    }
}

struct LedLens: Shape {
    var isGlowing: Bool = true
    func path(in rect: CGRect) -> Path {
        let width = rect.width
        let height = rect.height
        var p = Path()
        
        p.move(to: LedLensParameters.start(in: rect))
        LedLensParameters.segments.forEach { segment in
            p.addLine(
                to: CGPoint(
                    x: width*segment.line.x,
                    y: height*segment.line.y
                )
            )
            p.addCurve(
                to: CGPoint(
                    x: width*segment.curve.x,
                    y: height*segment.curve.y
                ),
                control1: CGPoint(
                    x: width*segment.control1.x,
                    y: height*segment.control1.y
                ),
                control2: CGPoint(
                    x: width*segment.control2.x,
                    y: height*segment.control2.y
                )
            )
        }

        return p
    }
    
}

struct LedIcon: View {
    let led_color: Color
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                LedLegs().fill(Color.gray)
                LedLens().fill(led_color)
                LedLens().stroke(Color.black, lineWidth: lens_lineWidth)
                LedInternals().fill(Color.black).opacity(internals_opacity)
            }
            .frame(width: geometry.size.height, height: geometry.size.height)
        }
    }
    
    // MARK: - LedIcon Drowing Constants
    private let lens_lineWidth: CGFloat = 1
    private let internals_opacity: Double = 0.2
    func led_size(for size: CGSize) -> CGFloat {
        min(size.width, size.height)
    }
}


struct LedIcon_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LedIcon(led_color: Color.init(red: 1, green: 0, blue: 0))
        }
    }
}
