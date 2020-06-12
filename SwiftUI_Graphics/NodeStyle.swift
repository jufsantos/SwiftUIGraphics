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
struct NodeStyle: ViewModifier {
    var style: TreeMapStyle
    var backgroundColor: Color
    
    func body(content: Content) -> some View {
        switch style {
        case .roundedRectangle:
            return AnyView(content
                .frame(width: 50, height: 50)             .background(RoundedRectangle(cornerRadius: 8).stroke())
                .background(RoundedRectangle(cornerRadius: 8).fill(backgroundColor))
                .padding(10))
            
        case .square:
            return AnyView(content
                .frame(width: 50, height: 50)             .background(Rectangle().stroke())
                .background(Rectangle().fill(backgroundColor))
                .padding(10))
            
        case .circle:
            return AnyView(content
                .frame(width: 50, height: 50)
                .background(Circle().stroke())
                .background(Circle().fill(backgroundColor))
                .padding(10))
        default:
            return AnyView(content
                .frame(width: 50, height: 50)
                .background(Circle().stroke())
                .background(Circle().fill(backgroundColor))
                .padding(10))
        }
        
    }
}


public enum TreeMapStyle {
    case circle
    case roundedRectangle
    case square
}
