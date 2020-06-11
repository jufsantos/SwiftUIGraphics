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
    var body: some View {
        Axis(lineWidth: 20)
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
        .padding([.bottom,.leading])
    }
}

struct ScatterPlotView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ScatterPlotView()
                .background(Color.blue)
                .previewDevice("iPad Pro (9.7-inch)")
            ScatterPlotView()
                .background(Color.blue)
                .previewDevice("iPhone Xs")
        }
    }
}
