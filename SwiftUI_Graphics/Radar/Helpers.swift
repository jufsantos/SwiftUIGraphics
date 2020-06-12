//
//  GraphView.swift
//  SwiftUI_Graphics
//
//  Created by Paula Leite on 12/06/20.
//  Copyright © 2020 Luiza Fattori. All rights reserved.
//

import SwiftUI

public struct AxisComponent: Hashable {
    var subtitle: String
    var max: Double
}

public struct GraphElement: Hashable {
    var subtitle: String
    var values: [Double]
    var color: Color
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
