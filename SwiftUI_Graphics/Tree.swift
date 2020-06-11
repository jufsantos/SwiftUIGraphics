//
//  Tree.swift
//  SwiftUI_Graphics
//
//  Created by Artur Carneiro on 11/06/20.
//  Copyright © 2020 Luiza Fattori. All rights reserved.
//

import Foundation

/// Representation of a Tree and, consequently, a Node also.
/// Created using objc-io tutorial on SwiftUI.
/// Source: https://www.objc.io/blog/2019/12/16/drawing-trees/
struct Tree<A: Codable> {
    /// The value of the Node.
    var value: A

    /// The children of a Node.
    var children: [Tree<A>] = []

    init(_ value: A, children: [Tree<A>] = [] ) {
        self.value = value
        self.children = children
    }
}

extension Tree {
    func map<B>(_ transform: (A) -> B) -> Tree<B> {
        Tree<B>(transform(value), children: children.map { $0.map(transform) })
    }
}
