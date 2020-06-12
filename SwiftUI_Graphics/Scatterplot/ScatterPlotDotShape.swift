//
//  ScatterPlotDotShape.swift
//  SwiftUI_Graphics
//
//  Created by Rafael Galdino on 12/06/20.
//  Copyright © 2020 Luiza Fattori. All rights reserved.
//

import Foundation
import SwiftUI

struct DotShape: Shape {
    var locations: [CGPoint]
    var size: CGFloat = 10

    func path(in rect: CGRect) -> Path {
        Path { path in
            guard !locations.isEmpty else { return }
            for location in locations {
                let x = (location.x * rect.width) - size/2
                let y = -((location.y * rect.height) + size/2) + rect.height
                let position = CGRect(x: x, y: y, width: size, height: size)
                path.addEllipse(in: position)
            }
        }
    }
}
