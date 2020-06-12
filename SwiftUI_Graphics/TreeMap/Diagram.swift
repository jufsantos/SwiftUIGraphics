//
//  Diagram.swift
//  SwiftUI_Graphics
//
//  Created by Artur Carneiro on 11/06/20.
//  Copyright © 2020 Luiza Fattori. All rights reserved.
//

import SwiftUI

/// Created using objc-io tutorial on SwiftUI.
/// Source: https://www.objc.io/blog/2019/12/16/drawing-trees/
struct Diagram<A: Identifiable & Codable, V: View>: View {
    let tree: Tree<A>
    let strokeColor: Color
    let node: (A) -> V
    
    typealias Key = CollectDict<A.ID, Anchor<CGPoint>>
    /**
     - TODO: Adicionar a customização da árvore.
     */
    var body: some View {
        return HStack(alignment: .center, spacing: 10) {
            node(tree.value)
                .anchorPreference(key: Key.self, value: .center) { [self.tree.value.id: $0] }
            VStack(alignment: .center, spacing: 10) {
                ForEach(tree.children, id: \.value.id, content: { child in
                    Diagram(tree: child, strokeColor: self.strokeColor, node: self.node)
                })
            }
        }.backgroundPreferenceValue(Key.self) { (centers: [A.ID: Anchor<CGPoint>]) in
            GeometryReader { proxy in
                ForEach(self.tree.children, id: \.value.id, content: { child in
                    Line(from: proxy[centers[self.tree.value.id]!],
                         to: proxy[centers[child.value.id]!])
                        .stroke(self.strokeColor)
                })
            }
        }
    }
}
