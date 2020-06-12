//
//  ScatterPlotViewModel.swift
//  SwiftUI_Graphics
//
//  Created by gabriel on 11/06/20.
//  Copyright © 2020 Luiza Fattori. All rights reserved.
//

import CoreGraphics

class ScatterPlotViewModel {
    
    let data: [Plottable]
    let maxX: CGFloat
    let maxY: CGFloat
    
    init(data: [Plottable]) {
        self.data = data
        maxX = (data.map{$0.xValue}.max() ?? 1) * 2
        maxY = (data.map{$0.yValue}.max() ?? 1) * 2
    }
    
    func getDotsPositions() -> [CGPoint] {
        var positions: [CGPoint] = []
        
        data.forEach{ (value: Plottable) in
            
            let xPosition = (value.xValue / maxX)
            let yPosition = (value.yValue / maxY)
            
            positions.append(CGPoint(x: xPosition, y: yPosition))
        }
        return positions
    }
}
