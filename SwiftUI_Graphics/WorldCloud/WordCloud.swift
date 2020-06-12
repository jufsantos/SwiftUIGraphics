//
//  WordGraphView.swift
//  ExerciseSwiftUI
//
//  Created by Zewu Chen on 10/06/20.
//  Copyright © 2020 Zewu Chen. All rights reserved.
//

import SwiftUI

/**
 A View that contains the Word Cloud.
 */
struct WordCloud: View {

    private let controller = TextParser()
    private var words = [WordModel]()
    private var minSize: Float
    private var maxSize: Float
    private var fontName: String
    private var colors: [Color]

    @State private var totalHeight = CGFloat.infinity

    /**
     Word Cloud initialiazer.
     
     You can set all of the structs variables on its initializazer, as shown in the example below:
     
     - parameters:
        - text: A String that contains that will be analysed and displayed as the Word Cloud.
        - fontName: A String that contains the name of the font that will be used to display the Word Cloud. **This is an optional parameter**. If you don't give it a value, the system's default font will be used.
        - minimumFontSize: A Float that represents the minimum size possible for font size. **This is an optional parameter**. If you don't give it a value, it will receive 20.0 as its default value.
        - maximumFontSize: A Float that represents the maximum size possible for font size. **This is an optional parameter**. If you don't give it a value, it will receive 50.0 as its default value.
        - colorSet: An array of instances of Color that will be used to display the Word Cloud.  **This is an optional parameter**. If you don't give it a value, it will receive programmatically set colors.
     
     ```
     WordCloud(
         text: "This is a text",
         fontName: "",
         minimumFontSize: 20,
         maximumFontSize: 50,
         colorSet: [.red, .blue, ,green]
     )
     ```
     In the example, ```fontName``` is set as an empty string. That means the text will be displayed with the system's default font.
     
     In this initializer, ```fontName```, ```minimumFontSize```, ```maximumFontSize``` and ```colorSet``` are **optional parameters**. If you don't give them a value, they will be set with their default values:
     - ```fontName: ""```
     - ```minimumFontSize = 20```
     - ```maximumFontSize = 50```
     - ```colorSet = [Color(#colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)), Color(#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)), Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1))```
     */
    init(text: String, fontName: String = "", minimumFontSize: Float = 20, maximumFontSize: Float = 50, colorSet: [Color] = []) {
        self.minSize = minimumFontSize
        self.maxSize = maximumFontSize
        
        let models = self.controller.parseText(text: text)
        
        self.words = self.controller.mapAndNormalizeWord(
            data: models,
            minSize: self.minSize,
            maxSize: self.maxSize
        )
        
        self.fontName = fontName
        
        if colorSet.isEmpty {
            self.colors = [Color(#colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)), Color(#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)), Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1))]
        } else {
            self.colors = colorSet
        }
    }
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                self.generateContent(in: geometry)
            }
        }
        .frame(maxHeight: totalHeight)
    }

    /**
     The method that arranges the words on the screen.
     - parameters:
        - g: The GeometryProxy that will contain the Word Cloud.
     
     - returns: A View to be displayed.
     */
    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        var maxHeight = CGFloat.zero
        
        return ZStack(alignment: .topLeading) {
            ForEach(0..<words.count) { index in
                self.item(for: self.words[index].word, size: self.words[index].size)
                    .padding([.horizontal, .vertical], 0)
                    .alignmentGuide(.leading, computeValue: { d in
                        if (abs(width - d.width) > g.size.width) {
                            width = 0
                            height -= maxHeight
                            maxHeight = .zero
                        }
                        
                        if d.height > maxHeight {
                            maxHeight = d.height
                        }
                        let result = width
                        if self.words[index].id == self.words.last?.id {
                            width = 0
                        } else {
                            width -= d.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: {d in
                        let result = height
                        if self.words[index].id == self.words.last?.id {
                            height = 0
                        }
                        return result
                    })
            }
        }.background(viewHeightReader($totalHeight))
    }

    /**
        A method that returns a WordView based on a String and a font size.
     
        - parameters:
            - text: A String containing the text that will be displayed.
            - size: The font size that will be attributed to this WordView.
     
        - returns: The WordView initialized with the text, the font size and the colors and font name set on init.
     
     */
    private func item(for text: String, size: Float) -> some View {
        WordView(word: text, size: size, colors: self.colors, fontName: fontName).fixedSize()
    }

    /**
     A method that returns a view based on a height value.
     
     - parameters:
        - binding: A CGFloat containing the height value.
     
     - returns:
        A View with a Color and the height passed to this method.
     */
    private func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
        return GeometryReader { geometry -> Color in
            let rect = geometry.frame(in: .local)
            DispatchQueue.main.async {
                binding.wrappedValue = rect.size.height
            }
            return .clear
        }
    }
    
    /**
     Public method to set the colors of the Word Cloud. **This method can be used as the view's modifier**.
     - parameters:
        - colorSet: An array of instances of Color that will be set to the Word Cloud.
     
     - returns: The instance itself, but with a new color set.
     */
    public func colorSet(_ colorSet: [Color]) -> Self {
        var copy = self
        copy.colors = colorSet
        return copy
    }
    
    /**
     Public method to set the font name of the Word Cloud. **This method can be used as the view's modifier**.
     - parameters:
        - fontName: A String containing the new font's name to set to the Word Cloud.
     
     - returns: The instance itself, but with a new font name.
     */
    public func fontName(_ fontName: String) -> Self {
        var copy = self
        copy.fontName = fontName
        return copy
    }
    
    /**
     Public method to set the font size of the Word Cloud. **This method can be used as the view's modifier**.
     - parameters:
        - minimum: A Float representing the minimum font size. **This is an optional parameters**. If you don't give it a value, it will be set as 20.0.
        - maximum: A Float representing the maximum font size. **This is an optional parameters**. If you don't give it a value, it will be set as 50.0.
     
     - returns: The instance itself, but with a new font size.
     */
    public func fontSize(minimum: Float = 20, maximum: Float = 50) -> Self {
        var copy = self
        copy.minSize = minimum
        copy.maxSize = maximum
        return copy
    }
}

struct TesteView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone XR"], id: \.self) { deviceName in
            WordCloud(text: "Mindset Mindset Mindset Mindset Mindset Mindset Mindset Networking Networking Networking Players Players Players Players Believe Believe Believe Work Work Work Business Stonks Stonks Stonks Stonks Top Antenado MenteAberta Suce$$o Power Power Power Power cr14t1v1d4d3 Otimista Realizador Autodeterminado Autoconfiança Inovação Inovação Inovação Originalidade Diferente Diferencial Diferencial Diferencial Valores Propósito Propósito Propósito Propósito Progresso Progresso Progresso Progresso Metas Metas Metas Potencial Ideia Lucro Dinheiro Superávit Superávit Superávit Superávit Sonhos Sonhos  Falhar Sacrifícios Fluxo Conquista Aventura Oportunidades Persistência Disciplina Inspiração Energia Ação Liderança Liderança Liderança Liderança Resultados Resultados Resultados Crescimento Performance FOCO FOCO FOCO FOCO FOCO Growth Growth Growth Growth Atitudes Atitudes Valores Orgulho Moral Produtividade Produtividade Produtividade Produtividade Produtividade Produtividade Equipe FalheRápido Feedback Obstáculos Garra Garra Perspectivas Desafios Desafios Confiança Confiança Goal Impacto Impacto Impacto")
            .colorSet([.blue,.red])
            .fontName("Courier")
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}
