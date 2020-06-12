//
//  ScatterPlotView.swift
//  SwiftUI_Graphics
//
//  Created by Rafael Galdino on 11/06/20.
//  Copyright © 2020 Luiza Fattori. All rights reserved.
//

import Foundation
import SwiftUI

struct ScatterPlotView: View {
    let viewModel: ScatterPlotViewModel
    
    init(data: [Plottable]) {
        viewModel = ScatterPlotViewModel(data: data)
    }
    
    var body: some View {
        let dotsPositions = viewModel.getDotsPositions()
        return ZStack {
                ZStack {
                    DotShape(locations: dotsPositions, size: 12)
                        .fill()
                        .foregroundColor(Color.red)
            }.padding(10)
        }
        .background(Axis(lineWidth: 10).foregroundColor(.orange))
    }
}

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

struct Axis: View {
    var lineWidth: CGFloat = 1
    var body: some View {
        ZStack {
            HStack {
                Rectangle()
                    .frame(width: lineWidth, height: nil, alignment: .leading)
                Spacer()
            }
            VStack {
                Spacer()
                Rectangle()
                    .frame(width: nil, height: lineWidth, alignment: .leading)
            }
        }
    }
}

struct ScatterPlotView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ScatterPlotView(data: [ScatterPlotData()])
                .background(Color.blue)
                .previewDevice("iPad Pro (9.7-inch)")
            ScatterPlotView(data: [ScatterPlotData()])
                .background(Color.blue)
                .previewDevice("iPhone Xs")
        }
    }
}

struct ScatterPlotData: Plottable {
    var xValue: CGFloat = 200
    var yValue: CGFloat = 30
}

protocol Plottable {
    var xValue: CGFloat {get set}
    var yValue: CGFloat {get set}
}
