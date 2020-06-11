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
    init(_ points: [CGPoint], color: Color = .random()) {
        self.points = points
        self.color = color
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
        }.stroke(color, lineWidth: 1.5).aspectRatio(1, contentMode: .fit)
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
