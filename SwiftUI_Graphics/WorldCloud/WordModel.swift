//
//  WordModel.swift
//  ExerciseSwiftUI
//
//  Created by Zewu Chen on 11/06/20.
//  Copyright © 2020 Zewu Chen. All rights reserved.
//

import Foundation

/**
 The representation of a Word in the Word Cloud.
 
 Words, as in this model, have an identifier, a text, a value and a size.
 The value of a Word represents its relative weight in a text and the size, the font size that will be used to represent this word.
 */
class WordModel: Identifiable {
    let id = UUID()

    let word: String
    var value: Int
    var size: Float

    /**
     WordModel initializer.
     
     - parameters:
        - word: A String that contains the text of this WordModel.
        - value: The weight value of a word inside a text.
        - size: The font size that will be used to represent this word. **This is an optional parameter**. If you don't give it a size, it will receive its default value: 10.0.
     */
    init(word: String, value: Int = 0, size: Float = 10.0) {
        self.word = word
        self.value = value
        self.size = size
    }
}
