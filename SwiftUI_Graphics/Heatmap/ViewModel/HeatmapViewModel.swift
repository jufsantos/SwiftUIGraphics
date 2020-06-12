//
//  HeatmapViewModel.swift
//  SwiftUI_Graphics
//
//  Created by Edgar Sgroi on 11/06/20.
//  Copyright © 2020 Luiza Fattori. All rights reserved.
//

import Foundation
import SwiftUI

struct HeatmapViewModel {
    
    let rowElements: [String]
    let colElements: [String]
    let data: [[Float]]
    var valuesMarks: [Float]
    let colorRGB: String
    let size: Float = 50
    let borderWidth: Float = 0.2
    
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
        guard let max = valuesMarks.first else { return 1.0 }
        for i in 0..<valuesMarks.count {
            if (value > valuesMarks[i]) {
                return valuesMarks[i-1]/max
            } else if (value == valuesMarks[i]) {
                return valuesMarks[i]/max
            }
        }
        return value/max
    }
    
    func getDataValue(row: Int, col: Int) -> Float {
        return data[row][col]
    }
    
    func getColumnName(col: Int) -> String {
        return colElements[col]
    }
    
    func getRowName(row: Int) -> String {
        return rowElements[row]
    }
    
    mutating func reorderArray() {
        valuesMarks = valuesMarks.sorted(by: >)
//        valuesMarks.reverse()
    }
}
