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
        GeometryReader { (proxy: GeometryProxy) in
            ZStack {
                VStack {
                    Spacer()
                    ZStack() {
                        Axis(lineWidth: 20)
                    }
                }
                Dot(at: CGPoint(x: proxy.size.width/2, y: proxy.size.height/2), size: 20)
            }
        }
    }
}

struct Dot: View {
    var size: CGFloat = 5
    var origin: CGPoint = .zero

    var body: some View {
        Circle()
        .path(in: CGRect(origin: origin, size: CGSize(width: size, height: size)))
    }

    init(at location: CGPoint, size: CGFloat?) {
        if let size = size {
            self.size = size
        }
        self.origin = CGPoint(x: location.x - self.size/2,
                              y: location.y - self.size/2)
    }
}

struct Axis: View {
    #warning("ZStack does not reach top of the screen")
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
