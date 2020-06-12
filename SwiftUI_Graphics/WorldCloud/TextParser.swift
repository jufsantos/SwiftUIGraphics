//
//  WordController.swift
//  ExerciseSwiftUI
//
//  Created by Zewu Chen on 11/06/20.
//  Copyright © 2020 Zewu Chen. All rights reserved.
//

import Foundation

/**
 The parser that reads and interprets a text received as String.
 */
final class TextParser {

    /**
    Parse a generic text to a WordModel array
     
    - parameter text: A String that contains the text that will be converted
    - version: 1.0
    - returns: Array of data parsed as WordModel. See WordModel Structure for more info.
    */
    public func parseText(text: String) -> [WordModel] {
        var result: [WordModel] = []
        let splited = text.replacingOccurrences(of: "[|@#$%^&*|:()-,;!{}+'\']", with: "", options: .regularExpression).split(separator: " ")

        for item in splited {
            result.append(WordModel(word: item.description))
        }

        return result
    }

    /**
    Processes data, setting font size and recognizing repeated words.
    - parameters:
        - data: An array of WordModel with the values to be processed. See WordModel Structure for more info.
        - minSize: A Float that represents the minimum size possible for font size.
        - maxSize: A Float that represents the maximum size possible for font size.
        - isUppercase: A Boolean that sets words to uppercase when true. **This is an optional parameter**. If you don't give it a value, it will receive false as its default value.
    - version: 1.0
    - returns: An array of treated data as WordModel with normalized font and reduced repeated words.
    */
    public func mapAndNormalizeWord(data: [WordModel], minSize: Float, maxSize: Float, isUppercase: Bool = false) -> [WordModel] {
        var result: [WordModel] = []

        result = self.mapWord(data: data, isUppercase: isUppercase)
        result = self.normalizeWordFont(data: result, minSize: minSize, maxSize: maxSize)

        return result
    }

    /**
    Processes data to avoid repeated words.
    - parameters:
        - data: An array of WordModel with the values to be processed. See WordModel Structure for more info.
        - isUppercase: A Boolean that sets words to uppercase when true.
    - version: 1.0
    - returns: An array of treated data as WordModel with reduced repeated words.
    */
    private func mapWord(data: [WordModel], isUppercase: Bool) -> [WordModel] {
        var dataAux: [String: Int] = [:]
        var result: [WordModel] = []

        if isUppercase {
            for item in data {
                dataAux[item.word.uppercased()] = (dataAux[item.word.uppercased()] ?? 0) + 1
            }
        } else {
            for item in data {
                dataAux[item.word] = (dataAux[item.word] ?? 0) + 1
            }
        }

        for (word, value) in dataAux {
            result.append(WordModel(word: word, value: value))
        }

        return result
    }

    /**
    Processes data to set the font size.
    - parameters:
        - data: An array of WordModel with the values to be processed. See WordModel Structure for more info.
        - minSize: A Float that represents the minimum size possible for font size.
        - maxSize: A Float that represents the maximum size possible for font size.
    - version: 1.0
    - returns: An array of treated data as WordModel with normalized font size in each word.
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
        if let _ = minValue?.value, let maxValue = maxValue?.value {
            let _ = data.map {
                let value = $0.value
                $0.size = ((Float(value) * maxSize) / Float(maxValue)) < minSize ? minSize : (Float(value) * maxSize) / Float(maxValue)
            }
        }

        return data
    }
}
