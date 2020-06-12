//
//  ScatterPlotViewModel.swift
//  SwiftUI_Graphics
//
//  Created by gabriel on 11/06/20.
//  Copyright © 2020 Luiza Fattori. All rights reserved.
//

import CoreGraphics

struct ScatterPlotData: Plottable {
    var xValue: CGFloat
    var yValue: CGFloat

    init<T : BinaryFloatingPoint>(_ xValue: T, _ yValue: T) {
        self.xValue = CGFloat(xValue)
        self.yValue = CGFloat(yValue)
    }

    init<T : BinaryInteger>(_ xValue: T, _ yValue: T) {
        self.xValue = CGFloat(xValue)
        self.yValue = CGFloat(yValue)
    }
}

class ScatterPlotViewModel {
    
    let model: ScatterPlotModel
    
    init(data: [Plottable]) {
        var maxX: Double = 1
        var maxY: Double = 1
        if !data.isEmpty {
            if let maximumX = data.map({$0.xValue}).max(), let maximumY = data.map({$0.yValue}).max() {
                maxX = Double(maximumX)
                maxY = Double(maximumY)
            }
        }
        self.model = ScatterPlotModel(data: data, maxX: maxX, maxY: maxY)
    }

    init<T: BinaryInteger>(_ xAxis: [T], _ yAxis: [T]) {
        var data: [Plottable] = []
        for index in 0..<(xAxis.count >= yAxis.count ? yAxis.count : xAxis.count) {
            data.append(ScatterPlotData(xAxis[index], yAxis[index]))
        }
        var maxX: Double = 1
        var maxY: Double = 1
        if !data.isEmpty {
            if let maximumX = data.map({$0.xValue}).max(), let maximumY = data.map({$0.yValue}).max() {
                maxX = Double(maximumX)
                maxY = Double(maximumY)
            }
        }
        self.model = ScatterPlotModel(data: data, maxX: maxX, maxY: maxY)
    }

    init<T: BinaryFloatingPoint>(_ xAxis: [T], _ yAxis: [T]) {
        var data: [Plottable] = []
        for index in 0..<(xAxis.count >= yAxis.count ? yAxis.count : xAxis.count) {
            data.append(ScatterPlotData(xAxis[index], yAxis[index]))
        }
        var maxX: Double = 1
        var maxY: Double = 1
        if !data.isEmpty {
            if let maximumX = data.map({$0.xValue}).max(), let maximumY = data.map({$0.yValue}).max() {
                maxX = Double(maximumX)
                maxY = Double(maximumY)
            }
        }
        self.model = ScatterPlotModel(data: data, maxX: maxX, maxY: maxY)
    }

    func getDotsPositions() -> [CGPoint] {
        var positions: [CGPoint] = []
        
        model.data.forEach{ (value: Plottable) in
            
            let xPosition = (value.xValue / CGFloat(model.maxX))
            let yPosition = (value.yValue / CGFloat(model.maxY))
            
            positions.append(CGPoint(x: xPosition, y: yPosition))
        }
        return positions
    }
}
