//
//  RoundedCircleStyle.swift
//  SwiftUI_Graphics
//
//  Created by Artur Carneiro on 11/06/20.
//  Copyright © 2020 Luiza Fattori. All rights reserved.
//

import SwiftUI

/// Created using objc-io tutorial on SwiftUI.
/// Source: https://www.objc.io/blog/2019/12/16/drawing-trees/
struct RoundedCircleStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 50, height: 50)
            .background(Circle().stroke())
            .background(Circle().fill(Color.red))
            .padding(10)
    }
}
