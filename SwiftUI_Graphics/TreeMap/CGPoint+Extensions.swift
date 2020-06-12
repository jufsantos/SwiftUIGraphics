//
//  CGPoint+Extensions.swift
//  SwiftUI_Graphics
//
//  Created by Artur Carneiro on 11/06/20.
//  Copyright © 2020 Luiza Fattori. All rights reserved.
//

import SwiftUI

extension CGPoint: VectorArithmetic {
    public static func - (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }


    public mutating func scale(by rhs: Double) {
        let newX = self.x * CGFloat(rhs)
        let newY = self.y * CGFloat(rhs)
        self.x = newX
        self.y = newY
    }

    public var magnitudeSquared: Double {
        (Double(self.x * self.x) + Double(self.y * self.y))
    }

    public static func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
}
