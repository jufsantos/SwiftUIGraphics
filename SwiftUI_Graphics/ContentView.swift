//
//  ContentView.swift
//  SwiftUI_Graphics
//
//  Created by Luiza Fattori on 10/06/20.
//  Copyright © 2020 Luiza Fattori. All rights reserved.
//

import SwiftUI

let binaryTree = Tree<Int>(50, children: [
    Tree(17, children: [
        Tree(12),
        Tree(15),
        Tree(23)
    ]),
    Tree(72, children: [
        Tree(54),
        Tree(72)
    ])
])

let uniqueTree: Tree<Unique<Int>> = binaryTree.map(Unique.init)

struct ContentView: View {
    @State var tree = uniqueTree
    var body: some View {
        Diagram(tree: tree) { value in
            Text("\(value.value)")
            .modifier(RoundedCircleStyle())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
