//
//  ScatterPlotView.swift
//  SwiftUI_Graphics
//
//  Created by Rafael Galdino on 11/06/20.
//  Copyright © 2020 Luiza Fattori. All rights reserved.
//

import Foundation
import SwiftUI

protocol Plottable {
    var xValue: CGFloat {get set}
    var yValue: CGFloat {get set}
}

struct ScatterPlot: View {
    let viewModel: ScatterPlotViewModel
    
    init(data: [Plottable]) {
        viewModel = ScatterPlotViewModel(data: data)
    }

    init<T: BinaryFloatingPoint>(xAxis: [T], yAxis: [T]) {
        viewModel = ScatterPlotViewModel(xAxis, yAxis)
    }

    init<T: BinaryInteger>(xAxis: [T], yAxis: [T]) {
        viewModel = ScatterPlotViewModel(xAxis, yAxis)
    }
    
    var body: some View {
        let dotsPositions = viewModel.getDotsPositions()
        return ZStack {
                ZStack {
                    DotShape(locations: dotsPositions, size: 12)
                        .fill()
                        .foregroundColor(Color.red)
            }.padding(10)
            Axis(lineWidth: 10).foregroundColor(.orange)
        }
    }
}



struct ScatterPlotView_Previews: PreviewProvider {
    static func randomizedIntData() -> [Int] {
        var arrayData: [Int] = []
        for _ in 0...60 {
            arrayData.append(Int.random(in: 0...60))
        }

        return arrayData
    }

    static func randomizedDoubleData() -> [Double] {
        var arrayData: [Double] = []
        for _ in 0...60 {
            arrayData.append(Double.random(in: 0...67))
        }

        return arrayData
    }

    static var previews: some View {
        Group {
            ScatterPlot(xAxis: ScatterPlotView_Previews.randomizedIntData(), yAxis: ScatterPlotView_Previews.randomizedIntData())
                .edgesIgnoringSafeArea(.all)
                .background(Color.clear)
                .previewDevice("iPad Pro (9.7-inch)")
            ScatterPlot(xAxis: ScatterPlotView_Previews.randomizedDoubleData(), yAxis: ScatterPlotView_Previews.randomizedDoubleData())
                .edgesIgnoringSafeArea(.all)
                .background(Color.clear)
                .previewDevice("iPhone Xs")
        }
    }
}
