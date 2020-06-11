//
//  SBDataManager.swift
//  SwiftUI_Graphics - Sunburst
//
//  Created by Lucas and Pedro on 10/06/20.
//  Copyright © 2020 Lucas and Pedro. All rights reserved.
//

import Foundation

/// Creates an object that will controll the state of the Sunburst Chart, managing the current root and the visible levels.
///
/// Example:
///
///     let root = SBData<Double>(name: "root", value: 100)
///     let manager = SBDataManager<Double>(root: root)
///
class SBDataManager<T: Numeric> {
    private(set) var currentRoot: SBData<T>
    private(set) var visibleLevels: Int

    init(root: SBData<T>, visibleLevels: Int = 3) {
        self.currentRoot = root
        self.visibleLevels = visibleLevels
    }


    /// Set the number of visible levels on the chart.
    /// The default value is 3.
    ///
    /// Example:
    ///
    ///     let root = SBData<Double>(name: "root", value: 100)
    ///     let manager = SBDataManager<Double>(root: root)
    ///     manager.setVisibleLevels(to: 5)
    ///
    /// - Parameter visibleLevels: The number of required visible levels.
    func setVisibleLevels(to visibleLevels: Int) {
        guard visibleLevels > 0 else { return }
        self.visibleLevels = visibleLevels
    }


    /// Go further into the next level, changing the root to a specific child.
    /// Make sure that the child used as a parameter has at least one children.
    ///
    /// Example:
    ///
    ///     let root = SBData<Double>(name: "root")
    ///     let documents = SBData<Double>(name: "Documents", value: 50)
    ///     root.addChild(documents)
    ///
    ///     let manager = SBDataManager<Double>(root: root)
    ///     manager.goFurther(basedOn: documents)
    ///
    /// - Parameter child: Child to be used as the new root.
    func goFurther(basedOn child: SBData<T>) {
        guard !child.children.isEmpty else { return }
        self.currentRoot = child
    }


    /// Go back to the previous level, changing the root to the current root's parent.
    ///
    /// Example:
    ///
    ///     let root = SBData<Double>(name: "root")
    ///     let documents = SBData<Double>(name: "Documents", value: 50)
    ///     root.addChild(documents)
    ///
    ///     let manager = SBDataManager<Double>(root: root)
    ///     manager.goFurther(basedOn: documents)
    ///     manager.goBack()
    ///
    func goBack() {
        guard let parent = self.currentRoot.parent else { return }
        self.currentRoot = parent
    }


    /// Check if the current root is the original root.
    ///
    /// Example:
    ///
    ///     let root = SBData<Double>(name: "root")
    ///
    ///     let manager = SBDataManager<Double>(root: root)
    ///     if manager.isOriginalRoot() {
    ///         print("The current root is the original root")
    ///     } else {
    ///         print("The current root isn't the original root")
    ///     }
    ///
    func isOriginalRoot() -> Bool {
        return currentRoot.parent == nil
    }
}
