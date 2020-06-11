//
//  WordController.swift
//  ExerciseSwiftUI
//
//  Created by Zewu Chen on 11/06/20.
//  Copyright © 2020 Zewu Chen. All rights reserved.
//

import Foundation

final class WordController {
    
    /**
    *Data processing (font and repeated words)*
    - parameter data: [WordModel] - array of word with the values. See WordModel Structure
    - parameter isUppercase: Bool - set words to uppercase, false by default
    - version: 1.0
    - returns: Vector of treated data with with normalized font and reduced repeated words
    */
    public func mapAndNormalizeWord(data: [WordModel], minSize: Float, maxSize: Float, isUppercase: Bool = false) -> [WordModel] {
        var result: [WordModel] = []

        result = self.mapWord(data: data, isUppercase: isUppercase)
        result = self.normalizeWordFont(data: result, minSize: minSize, maxSize: maxSize)

        return result
    }

    /**
    *Data processing (repeated words)
    - parameter data: [WordModel] - array of word with the values. See WordModel Structure
    - parameter isUppercase: Bool - set words to uppercase
    - version: 1.0
    - returns: Vector of treated data with reduced repeated words
    */
    private func mapWord(data: [WordModel], isUppercase: Bool) -> [WordModel] {
        var dataAux: [String: Int] = [:]
        var result: [WordModel] = []

        /*
            // MARK: Use the way below instead of this way, because of the performance point of view in comparing many IF'S

            for item in data {
                dataAux[isUppercase ? item.word.uppercased() : item.word] = (dataAux[isUppercase ? item.word.uppercased() : item.word] ?? 0) + 1
            }
        */

        // Checks the same words and increases their values
        // Verify if is uppercase
        if isUppercase {
            for item in data {
                dataAux[item.word.uppercased()] = (dataAux[item.word.uppercased()] ?? 0) + 1
            }
        } else {
            for item in data {
                dataAux[item.word] = (dataAux[item.word] ?? 0) + 1
            }
        }

        // Make parse the auxData to return type
        for (word, value) in dataAux {
            result.append(WordModel(word: word, value: value))
        }

        return result
    }

    /**
    *Data processing (font size)
    - parameter data: [WordModel] - array of word with the values. See WordModel Structure
    - parameter minSize: Float - value of min size to normalize font
    - parameter maxSize: Float - value of max size to normalize font
    - version: 1.0
    - returns: Vector of treated data with font size normalized in each word
    */
    private func normalizeWordFont(data: [WordModel], minSize: Float, maxSize: Float) -> [WordModel] {
        // Lowest word value
        let minValue = data.min {
            a, b in a.value > b.value
        }

        // Highest word value
        let maxValue = data.max {
            a, b in a.value < b.value
        }

        // Normalizes the font size by the value of occurrences of the word
        if let minValue = minValue?.value, let maxValue = maxValue?.value {
            data.map {
                let value = $0.value
                $0.size = ((Float(value) * maxSize) / Float(maxValue)) < minSize ? minSize : (Float(value) * maxSize) / Float(maxValue)
            }
        }

        return data
    }
}
