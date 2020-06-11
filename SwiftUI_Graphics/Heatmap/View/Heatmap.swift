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
        HStack(spacing: 0) {
            ForEach(0..<viewModel.colElements.count) { col in
                VStack(alignment: .trailing, spacing: 0) {
                    ForEach(0..<self.viewModel.rowElements.count) { row in
                        HStack {
                            if col == 0 {
                                Text(self.viewModel.getRowName(row: row)).multilineTextAlignment(.trailing).frame(width: CGFloat(self.viewModel.size))
                            }
                            self.setColorRectangle(row: row, col: col)
                            
                            //                        self.colorVariation()
                        }
                    }
                    Text(self.viewModel.getColumnName(col: col)).frame(width: CGFloat(self.viewModel.size))
                        
                }
            }
        }
    }
}

extension Heatmap {
    func setColorRectangle(row: Int, col: Int) -> some View {
        let value = self.viewModel.getDataValue(row: row, col: col)
        let alpha: Double = Double(viewModel.colorVariation(value: value))
        return Rectangle().foregroundColor(Color(#colorLiteral(red: 0.1252194643, green: 0, blue: 0.732506752, alpha: 1)).opacity(alpha)).frame(width: CGFloat(viewModel.size), height: CGFloat(viewModel.size)).border(Color.black, width: CGFloat(self.viewModel.borderWidth))
    }
}

struct Heatmap_Previews: PreviewProvider {
    static var previews: some View {
        Heatmap(rowElements: ["AFEFF", "A", "A"], colElements: ["0", "2", "3"], data: [[5,6,7], [8,9,4], [5,6,7]], valuesRange: [3, 5, 9], colorRGB: "")
    }
}
