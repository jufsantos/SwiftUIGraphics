//
//  WordView.swift
//  ExerciseSwiftUI
//
//  Created by Zewu Chen on 11/06/20.
//  Copyright © 2020 Zewu Chen. All rights reserved.
//

import SwiftUI

/**
 A view that displays text with a certain font and color.
 
 You can set all of the structs variables on its initializazer, as shown in the example below:
 
 ```
 WordView(
     word: "Text",
     size: 20.0,
     colors: [.red, .blue, ,green],
     fontName: ""
 )
 ```
 In the example, ```fontName``` is set as an empty string. That means the text will be displayed with the system's default font.
 */
struct WordView: View {
    let word: String
    let size: Float
    let colors: [Color]
    let fontName: String

    var body: some View {
        return Text(word)
            .font(fontName.isEmpty ? .system(size: CGFloat(size)) : .custom(fontName, size: CGFloat(size)))
            .foregroundColor(colors[Int.random(in: 0..<colors.count)])
    }
}

struct WordView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone XR"], id: \.self) { deviceName in
            WordView(
                word: "Palavra extremamente grande",
                size: 20.0,
                colors: [Color(#colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)), Color(#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)), Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1))], fontName: ""
            )
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}
