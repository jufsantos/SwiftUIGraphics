//
//  TreeMap.swift
//  SwiftUI_Graphics
//
//  Created by Artur Carneiro on 11/06/20.
//  Copyright © 2020 Luiza Fattori. All rights reserved.
//

import SwiftUI

/// Customization allowed:
/// - Color
/// - Content
/// - Shape styles
/// - Content-specific color
/// - Level-specific color
/// - Orientation (vertical, horizontal)
/// - Line


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

let binaryTreeString = Tree<String>("OI", children: [
    Tree("JÃO", children: [
        Tree("COMO"),
        Tree("ASSIM"),
        Tree("VOCÊ")
    ]),
    Tree("NÃO", children: [
        Tree("BEBE"),
        Tree("?!?!")
    ])
])

public struct TreeMap<A: Codable>: View {
    private var tree: Tree<Unique<A>>
    public var body: some View {
        Diagram(tree: tree) { value in
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
            .modifier(RoundedCircleStyle()))
        case is Int:
            guard let value = value as? Int else {
                return AnyView(Text("ERROR"))
            }
            return AnyView(Text(String(value))
            .modifier(RoundedCircleStyle()))
        default:
            guard let value = value as? String else {
                return AnyView(Text("ERROR"))
            }
            return AnyView(Text(value)
            .modifier(RoundedCircleStyle()))
        }
    }

    init(tree: Tree<A>) {
        self.tree = tree.map(Unique.init)
    }
}

struct TreeMap_Previews: PreviewProvider {
    static var previews: some View {
        TreeMap<String>(tree: binaryTreeString)
    }
}
