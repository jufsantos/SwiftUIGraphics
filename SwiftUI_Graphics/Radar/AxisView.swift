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
                
                ZStack {
                    
                    LineView(color: self.color) { () -> [CGPoint] in
                        let center = geo.center()

                        let interval = self.degreeInterval * Double(index + 1)
                
                        let nextPoint = center.findPointIn(radius: 150, radians: interval)
                        
                        return [center, nextPoint]
                    }
                    
                    Text("\(self.components[index].subtitle)").position(geo.center().findPointIn(radius: 175, radians: self.degreeInterval*Double(index + 1)))
                }
            }
        }
    }
}



extension CGPoint {
    static func +(p1:CGPoint, p2:CGPoint) -> CGPoint {
        return CGPoint(x: p1.x + p2.x, y: p1.y+p2.y)
    }
    
    func findPointIn(radius: Double, radians: Double) -> CGPoint{
        return self + CGPoint(x: radius * cos(radians), y: radius * sin(radians))
    }
    
}
extension GeometryProxy {
    func center() -> CGPoint {
        return CGPoint(x: self.frame(in: .global).midX, y: self.frame(in: .global).midY)
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
