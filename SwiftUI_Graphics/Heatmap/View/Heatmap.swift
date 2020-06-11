//
//  Heatmap.swift
//  SwiftUI_Graphics
//
//  Created by Edgar Sgroi on 11/06/20.
//  Copyright © 2020 Luiza Fattori. All rights reserved.
//

import SwiftUI

struct Heatmap: View {
    
    let viewModel: HeatmapViewModel
    
    init(rowElements: [String], colElements: [String], data: [[Float]], valuesRange: [Float], colorRGB: String) {
        self.viewModel = HeatmapViewModel(rowElements: rowElements, colElements: colElements, data: data, valuesRange: valuesRange, colorRGB: colorRGB)
        
        viewModel.checkElementQntd()
    }
    
    var body: some View {
        HStack {
            ForEach(0..<viewModel.rowElements.count) {row in
                VStack {
                    ForEach(0..<self.viewModel.colElements.count) { col in
                        self.setColorRectangle(row: row, col: col)
//                        self.colorVariation()
                    }
                }
            }
        }
    }
}

extension Heatmap {
    func setColorRectangle(row: Int, col: Int) -> some View {
        let value = self.viewModel.getDataValue(row: row, col: col)
        let alpha: Double = Double(viewModel.colorVariation(value: value))
        return Rectangle().foregroundColor(Color(#colorLiteral(red: 0.1252194643, green: 0, blue: 0.732506752, alpha: 1)).opacity(alpha)).frame(width: 50.0, height: 50.0)
    }
}

struct Heatmap_Previews: PreviewProvider {
    static var previews: some View {
        Heatmap(rowElements: ["A", "B", "C"], colElements: ["1", "2", "3"], data: [[5,6,7], [8,9,0], [5,6,7]], valuesRange: [3, 5, 9], colorRGB: "")
    }
}
