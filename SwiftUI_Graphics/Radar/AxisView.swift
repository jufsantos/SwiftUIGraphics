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
    
    var components: [AxisComponent]
    
    var degreeInterval: Double {
        return (Double.pi * 2) / Double(components.count)
    }
    
    init(_ components: AxisComponent...) {
        self.components = components
    }
    
    var body: some View {
        
        GeometryReader { geo in
            
            ForEach(0..<self.components.count) { (index) in
                
                LineView { () -> [CGPoint] in
                    let center = CGPoint(x: geo.frame(in: .global).midX, y: geo.frame(in: .global).midY)
                    
                    let interval = self.degreeInterval * Double(index + 1)
                    
                    let nextX = Double(center.x) + 150 * cos(interval)
                    let nextY = Double(center.y) + 150 * sin(interval)
                    let nextPoint = CGPoint(x: nextX, y: nextY)
                    
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
