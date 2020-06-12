//
//  CollectDict.swift
//  SwiftUI_Graphics
//
//  Created by Artur Carneiro on 11/06/20.
//  Copyright © 2020 Luiza Fattori. All rights reserved.
//

import SwiftUI

/// Created using objc-io tutorial on SwiftUI.
/// Source: https://www.objc.io/blog/2019/12/16/drawing-trees/
struct CollectDict<Key: Hashable, Value>: PreferenceKey {
    static var defaultValue: [Key: Value] { [:] }
    static func reduce(value: inout [Key: Value], nextValue: () ->[Key:Value]) {
        value.merge(nextValue(), uniquingKeysWith: { $1 })
    }
}
