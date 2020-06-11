//
//  SBData.swift
//  SwiftUI_Graphics - Sunburst
//
//  Created by Lucas and Pedro on 10/06/20.
//  Copyright © 2020 Lucas and Pedro. All rights reserved.
//

import Foundation

/// Creates an object that will be used on the Sunburst Chart.
///
/// Example:
///
///     let root = SBData<Double>(name: "root", value: 100)
///
class SBData<T: Numeric>: Equatable {
    let id = UUID().uuidString
    var name: String
    private(set) weak var parent: SBData?
    private(set) var value: T
    private(set) var children: [SBData?] = []

    init(name: String = "", value: T = 0) {
        self.name = name
        self.value = value
    }
    

    /// Set a custom value to the object.
    ///
    /// Example:
    ///
    ///     let root = SBData<Double>(name: "root", value: 100)
    ///     root.setValue(200)
    ///
    /// - Parameter value: The value that will be shown on the Sunburst Chart.
    func setValue(_ value: T) {
        self.value = value
    }


    /// Add a child into the object. It also defines the child's parent as the object itself.
    ///
    /// Example:
    ///
    ///     let root = SBData<Double>(name: "root")
    ///     let documents = SBData<Double>(name: "Documents", value: 50)
    ///     root.addChild(documents)
    ///
    /// - Parameter child: A SBData that will be added as a child of the object.
    func addChild(_ child: SBData) {
        if children.isEmpty { self.value = 0 }
        child.parent = self
        children.append(child)
        self.value += child.value
    }


    /// Add an array of children into the object. It also defines the children's parent as the object itself.
    ///
    /// Example:
    ///
    ///     let root = SBData<Double>(name: "root")
    ///     let documents = SBData<Double>(name: "Documents", value: 50)
    ///     let desktop = SBData<Double>(name: "Desktop", value: 50)
    ///     root.addChildren([documents, desktop])
    ///
    /// - Parameter child: A SBData that will be added as a child of the object.
    func addChildren(_ children: [SBData]) {
        children.forEach {
            self.addChild($0)
        }
    }


    /// Remove a specific child of the object.
    ///
    /// Example:
    ///
    ///     let root = SBData<Double>(name: "root")
    ///     let documents = SBData<Double>(name: "Documents", value: 50)
    ///     root.addChild(documents)
    ///     root.removeChild(documents)
    ///
    /// - Parameter child: The child to be removed from the object.
    func removeChild(_ child: SBData) {
        if let index = children.firstIndex(of: child) {
            self.removeChild(at: index)
        }
    }


    /// Remove a child of the object at a specific index.
    ///
    /// Example:
    ///
    ///     let root = SBData<Double>(name: "root")
    ///     let documents = SBData<Double>(name: "Documents", value: 50)
    ///     root.addChild(documents)
    ///     root.removeChild(at: 0)
    ///
    /// - Parameter child: The index of the child to be removed from the object.
    func removeChild(at index: Int) {
        if let child = children.remove(at: index) {
            child.parent = nil
            self.value -= child.value
        }
    }


    static func ==(lhs: SBData, rhs: SBData) -> Bool {
        return lhs.id == rhs.id
    }
}
