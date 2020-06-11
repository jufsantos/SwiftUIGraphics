//
//  HeatmapViewModel.swift
//  SwiftUI_Graphics
//
//  Created by Edgar Sgroi on 11/06/20.
//  Copyright © 2020 Luiza Fattori. All rights reserved.
//

import Foundation

struct HeatmapViewModel {
    
    let rowElements: [String]
    let colElements: [String]
    let data: [[Float]]
    let valuesRange: [Float]
    let colorRGB: String
    
    func checkElementQntd() {
        let totalElements = rowElements.count * colElements.count
        let rowsQntd = data.count
        guard let collsQntd = data.first?.count else { return }
        let totalData = rowsQntd * collsQntd
        
        if totalElements != totalData {
            fatalError("The number of elements in data is diferent of number of elements expecting!")
        }
    }
    
    func colorVariation(value: Float) -> Float {
        guard let max = valuesRange.last else { return 1.0 }
        return value/max
    }
    
    func getDataValue(row: Int, col: Int) -> Float {
        return data[row][col]
    }
}
