//
//  Unique.swift
//  SwiftUI_Graphics
//
//  Created by Artur Carneiro on 11/06/20.
//  Copyright © 2020 Luiza Fattori. All rights reserved.
//

import Foundation

/// Created using objc-io tutorial on SwiftUI.
/// Source: https://www.objc.io/blog/2019/12/16/drawing-trees/
class Unique<A>: Identifiable {
    let value: A
    init(_ value: A) {
        self.value = value
    }
}
