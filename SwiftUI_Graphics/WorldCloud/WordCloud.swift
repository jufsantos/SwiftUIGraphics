//
//  WordGraphView.swift
//  ExerciseSwiftUI
//
//  Created by Zewu Chen on 10/06/20.
//  Copyright © 2020 Zewu Chen. All rights reserved.
//

import SwiftUI

// https://medium.com/flawless-app-stories/mvvm-in-swiftui-8a2e9cc2964a

struct WordCloud: View {

    private let controller = WordController()
    private var words = [WordModel]()
    private var minSize: Float
    private var maxSize: Float
    private var fontName: String
    private var colors: [Color]

    @State private var totalHeight = CGFloat.infinity

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

    private func item(for text: String, size: Float) -> some View {
        WordView(word: text, size: size, colors: self.colors, fontName: fontName).fixedSize()
    }

    private func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
        return GeometryReader { geometry -> Color in
            let rect = geometry.frame(in: .local)
            DispatchQueue.main.async {
                binding.wrappedValue = rect.size.height
            }
            return .clear
        }
    }
    
    public func colorSet(_ colorSet: [Color]) -> Self {
        var copy = self
        copy.colors = colorSet
        return copy
    }
    
    public func fontName(_ fontName: String) -> Self {
        var copy = self
        copy.fontName = fontName
        return copy
    }
    
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
