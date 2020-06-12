//
//  TreeMap.swift
//  SwiftUI_Graphics
//
//  Created by Artur Carneiro on 11/06/20.
//  Copyright © 2020 Luiza Fattori. All rights reserved.
//

import SwiftUI

/*
    Examples of Tree Diagrams using Int, Double and String.

    let binaryTree = Tree<Int>(50, children: [
        Tree(17, children: [
            Tree(12),
            Tree(22),
            Tree(23)
        ]),
        Tree(72, children: [
            Tree(54),
            Tree(72)
        ])
    ])

    let binaryTreeDouble = Tree<Double>(50.0, children: [
        Tree(17.0, children: [
            Tree(12.0),
            Tree(22.5),
            Tree(23.22)
        ]),
        Tree(72.1, children: [
            Tree(54.2323),
            Tree(72.3434)
        ])
    ])

    let binaryTreeString = Tree<String>("Este", children: [
        Tree("É", children: [
            Tree("Um"),
            Tree("Modelo"),
            Tree("De")
        ]),
        Tree("Diagrama", children: [
            Tree("De"),
            Tree("Árvore")
        ])
    ])
*/
public struct TreeMap<A: Codable>: View {
    private var strokeColor: Color
    private var style: TreeMapStyle
    private var shapeColor: Color
    private var tree: Tree<Unique<A>>
    
    public var body: some View {
        Diagram(tree: tree, strokeColor: strokeColor) { value in
            self.resolve(value.value)
        }
    }

    func resolve(_ value: A) -> AnyView {
        switch value {
        case is Double, is Float:
            guard let value = value as? CVarArg else {
                return AnyView(Text("ERROR"))
            }
            return AnyView(Text(String(format: "%.2f", value))
                .modifier(NodeStyle(style: style, backgroundColor: shapeColor)))
        case is Int:
            guard let value = value as? Int else {
                return AnyView(Text("ERROR"))
            }
            return AnyView(Text(String(value))
                .modifier(NodeStyle(style: style, backgroundColor: shapeColor)))
        default:
            guard let value = value as? String else {
                return AnyView(Text("ERROR"))
            }
            return AnyView(Text(value)
                .modifier(NodeStyle(style: style, backgroundColor: shapeColor)))
        }
    }

    public init(tree: Tree<A>, style: TreeMapStyle = .circle, shapeColor: Color = .pink, strokeColor: Color = .black) {
        self.tree = tree.map(Unique.init)
        self.style = style
        self.shapeColor = shapeColor
        self.strokeColor = strokeColor
    }
}
