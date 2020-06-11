//
//  WordGraphView.swift
//  ExerciseSwiftUI
//
//  Created by Zewu Chen on 10/06/20.
//  Copyright © 2020 Zewu Chen. All rights reserved.
//

import SwiftUI

// https://medium.com/flawless-app-stories/mvvm-in-swiftui-8a2e9cc2964a

struct WordGraphView: View {

    let controller = WordController()
    var palavras: [WordModel] = [
        WordModel(word: "5555555555"),
        WordModel(word: "5555555555"),
        WordModel(word: "2222222222"),
        WordModel(word: "3333333333"),
        WordModel(word: "4444444444"),
        WordModel(word: "5555555555"),
        WordModel(word: "1111111111"),
        WordModel(word: "2222222222"),
        WordModel(word: "3333333333"),
        WordModel(word: "4444444444"),
        WordModel(word: "5555555555"),
        WordModel(word: "Felipe"),
        WordModel(word: "Luiz"),
        WordModel(word: "Tamara"),
        WordModel(word: "Zewu"),
        WordModel(word: "Lia")
//        WordModel(word: "555555555"),
//        WordModel(word: "55555555"),
//        WordModel(word: "22222222"),
//        WordModel(word: "33333333"),
//        WordModel(word: "444444444"),
//        WordModel(word: "555555"),
//        WordModel(word: "1111111"),
//        WordModel(word: "222222222"),
//        WordModel(word: "3333333333"),
//        WordModel(word: "444444"),
//        WordModel(word: "55"),
//        WordModel(word: "Flipe"),
//        WordModel(word: "Liz"),
//        WordModel(word: "Tmara"),
//        WordModel(word: "Zwu"),
//        WordModel(word: "ia"),
//        WordModel(word: "1Felipe"),
//        WordModel(word: "1Luiz"),
//        WordModel(word: "1Tamara"),
//        WordModel(word: "1Zewu"),
//        WordModel(word: "1Lia"),
//        WordModel(word: "1555555555"),
//        WordModel(word: "155555555"),
//        WordModel(word: "122222222"),
//        WordModel(word: "133333333"),
//        WordModel(word: "1444444444"),
//        WordModel(word: "1555555"),
//        WordModel(word: "11111111"),
//        WordModel(word: "1222222222"),
//        WordModel(word: "13333333333"),
//        WordModel(word: "1444444"),
//        WordModel(word: "155"),
//        WordModel(word: "1Flipe"),
//        WordModel(word: "1Liz"),
//        WordModel(word: "1Tmara"),
//        WordModel(word: "1Zwu"),
//        WordModel(word: "1ia")
    ]

    init() {
        self.palavras = self.controller.mapAndNormalizeWord(data: palavras, minSize: 20, maxSize: 50)
    }

    var body: some View {
        VStack(alignment: .center) {
            ForEach(0..<palavras.count) { index in
                WordView(word: self.palavras[index].word, size: self.palavras[index].size).fixedSize()
//                Spacer().frame(width: CGFloat(Int.random(in: 0...200)))
            }
        }.fixedSize(horizontal: true, vertical: false)
            .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight, alignment: .center)
            .scaledToFill()
    }

}

struct TesteView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone XR"], id: \.self) { deviceName in
            WordGraphView()
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}
