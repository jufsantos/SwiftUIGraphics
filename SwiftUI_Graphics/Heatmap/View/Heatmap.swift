//
//  Heatmap.swift
//  SwiftUI_Graphics
//
//  Created by Edgar Sgroi on 11/06/20.
//  Copyright © 2020 Luiza Fattori. All rights reserved.
//

import SwiftUI

struct Heatmap: View {
    
    var viewModel: HeatmapViewModel
    
    init(rowElements: [String], colElements: [String], data: [[Float]], valuesRange: [Float], colorRGB: String) {
        self.viewModel = HeatmapViewModel(rowElements: rowElements, colElements: colElements, data: data, valuesMarks: valuesRange, colorRGB: colorRGB)
        
        viewModel.checkElementQntd()
        viewModel.reorderArray()
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
                            
                        }
                    }
                    Text(self.viewModel.getColumnName(col: col)).frame(width: CGFloat(self.viewModel.size))
                        
                }
            }
            Spacer()
                .frame(width: CGFloat(0.5 * viewModel.size))
            VStack(spacing: 0) {
                ForEach(0..<self.viewModel.valuesMarks.count) { value in
                    HStack {
                        self.setLegendColor(value: Double(self.viewModel.valuesMarks[value]))
                        Text("\(Int(self.viewModel.valuesMarks[value]))")
                    }
                    
                }
                Text(" ")
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
    
    func setLegendColor(value: Double) -> some View {
        let width: CGFloat = CGFloat(self.viewModel.size/4)
        let height: CGFloat = CGFloat(self.viewModel.size)
        let alpha: Double = Double(viewModel.colorVariation(value: Float(value)))
        
        return Rectangle().foregroundColor(Color(#colorLiteral(red: 0.1227254197, green: 4.775218986e-05, blue: 0.7319039702, alpha: 1)))
                .opacity(alpha)
                .frame(width: width, height: height)
            .border(Color.black, width: 0.2)
    }
}

struct Heatmap_Previews: PreviewProvider {
    static var previews: some View {
        Heatmap(rowElements: ["AFEFF", "A", "A"], colElements: ["0", "2", "3"], data: [[5,6,7], [8,7,4], [5,6,7]], valuesRange: [3, 5, 9], colorRGB: "")
    }
}
