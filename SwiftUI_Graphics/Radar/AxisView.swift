//
//  AxisView.swift
//  SwiftUI_Graphics
//
//  Created by Leonardo Oliveira on 11/06/20.
//  Copyright © 2020 Luiza Fattori. All rights reserved.
//

import SwiftUI

struct AxisComponent: Hashable {
    
    var subtitle: String
    var scale: ClosedRange<Double>
}

struct AxisView: View {
    var color: Color
    var components: [AxisComponent]
    
    var degreeInterval: Double {
        return (Double.pi * 2) / Double(components.count)
    }
    
    init(color: Color = .random(), _ components: AxisComponent...) {
        self.components = components
        self.color = color
    }
    
    var body: some View {
        
        GeometryReader { geo in
            
            ForEach(0..<self.components.count) { (index) in
                
                LineView(color: self.color) { () -> [CGPoint] in
                    let center = CGPoint(x: geo.frame(in: .global).midX, y: geo.frame(in: .global).midY)
                    
                    let interval = self.degreeInterval * Double(index + 1)
            
                    let nextPoint = CGPoint(x: 150 * cos(interval), y: 150 * sin(interval)) + center
                    
                    return [center, nextPoint]
                }
            }
        }
    }
}

struct AxisView_Previews: PreviewProvider {
    static var previews: some View {
        AxisView(
            AxisComponent(subtitle: "A", scale: 0.0...10.0),
            AxisComponent(subtitle: "B", scale: 15.0...17.0),
            AxisComponent(subtitle: "C", scale: 0.5...60.7)
        )
    }
}

extension CGPoint {
    static func +(p1:CGPoint, p2:CGPoint) -> CGPoint{
        return CGPoint(x: p1.x + p2.x, y: p1.y+p2.y)
    }
    
}
