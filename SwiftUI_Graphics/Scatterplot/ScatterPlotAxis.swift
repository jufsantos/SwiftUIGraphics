//
//  ScatterPlotAxis.swift
//  SwiftUI_Graphics
//
//  Created by Rafael Galdino on 12/06/20.
//  Copyright © 2020 Luiza Fattori. All rights reserved.
//

import Foundation
import SwiftUI

struct Axis: View {
    var lineWidth: CGFloat = 1
    let spaceData: CGFloat = 50

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
            VStack {
                Spacer()

                HStack {
                    Spacer().frame(width: lineWidth, height: nil)
                    Spacer()
                    Rectangle()

                        .frame(width: lineWidth/1.5, height: lineWidth * 2, alignment: .leading)
                        .foregroundColor(.orange)
                    Spacer()

                    Rectangle()

                        .frame(width: lineWidth/1.5, height: lineWidth * 2, alignment: .leading)
                        .foregroundColor(.orange)

                    Spacer()
                    Rectangle()

                        .frame(width: lineWidth/1.5, height: lineWidth * 2, alignment: .leading)
                        .foregroundColor(.orange)
                    Spacer()

                    Rectangle()

                        .frame(width: lineWidth/1.5, height: lineWidth * 2, alignment: .leading)
                        .foregroundColor(.orange)
                    Spacer()
                }
            }
            HStack {
                VStack {

                    Spacer()
                    Rectangle()

                        .frame(width: lineWidth * 2, height: lineWidth/1.5, alignment: .leading)
                        .foregroundColor(.orange)
                    Spacer()

                    Rectangle()

                        .frame(width: lineWidth * 2, height: lineWidth/1.5, alignment: .leading)
                        .foregroundColor(.orange)

                    Spacer()
                    Rectangle()

                        .frame(width: lineWidth * 2, height: lineWidth/1.5, alignment: .leading)
                        .foregroundColor(.orange)
                    Spacer()

                    Rectangle()

                        .frame(width:lineWidth * 2, height: lineWidth/1.5, alignment: .leading)
                        .foregroundColor(.orange)
                    Spacer()
                    Spacer().frame(width: nil, height: lineWidth)
                }
                Spacer()
            }
        }
    }
}
