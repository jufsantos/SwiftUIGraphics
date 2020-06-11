//
//  WordModel.swift
//  ExerciseSwiftUI
//
//  Created by Zewu Chen on 11/06/20.
//  Copyright © 2020 Zewu Chen. All rights reserved.
//

import Foundation

class WordModel: Identifiable {
    let id = UUID()

    let word: String
    var value: Int
    var size: Float

    init(word: String, value: Int = 0, size: Float = 10.0) {
        self.word = word
        self.value = value
        self.size = size
    }
}
