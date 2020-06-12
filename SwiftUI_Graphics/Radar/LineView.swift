//
//  LineView.swift
//  SwiftUI_Graphics
//
//  Created by Pedro Giuliano Farina on 11/06/20.
//  Copyright © 2020 Luiza Fattori. All rights reserved.
//

import SwiftUI

struct LineView: View {
    var color: Color
    var points: [CGPoint] = []
    
    init(color: Color = .random(), _ points: () -> [CGPoint] ) {
        self.points = points()
        self.color = color
    }
    
    init(color: Color = .random(), _ points: [CGPoint]) {
        self.points = points
        self.color = color
    }
    
    init(color: Color, axisView: GraphView, axisComponents: [AxisComponent], values: [Double]) {
        var points: [CGPoint] = []
        for i in 0 ..< axisComponents.count {
            if let point = axisView.findPoint(values[i], in: axisComponents[i]) {
                points.append(point)
            }
        }
        
        self.init(color: color, points)
    }

    var body: some View {
        Path { path in
            var copy = points
            let first = copy.removeFirst()
            path.move(to: first)
            for point in copy {
                path.addLine(to: point)
            }
            path.addLine(to: first)
        }.stroke(color, lineWidth: 2)
    }
}

#if DEBUG
struct LineView_Previews: PreviewProvider {
    static var previews: some View {
        LineView([CGPoint(x: 20, y: 20), CGPoint(x: 40, y: 40), CGPoint(x: 0, y: 40)])
    }
}
#endif

extension Color {
    public static func random() -> Color {
        return Color(UIColor(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1))
    }
}
