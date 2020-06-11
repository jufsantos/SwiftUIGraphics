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

    let text: String
    let controller = WordController()
    var palavras: [WordModel] = []
    @State private var totalHeight = CGFloat.infinity

    init(text: String) {
        self.text = text
        self.palavras = self.controller.parseText(text: text)
        self.palavras = self.controller.mapAndNormalizeWord(data: palavras, minSize: 20, maxSize: 50)
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
            ForEach(0..<palavras.count) { index in
                self.item(for: self.palavras[index].word, size: self.palavras[index].size)
                    .padding([.horizontal, .vertical], 0)
                    .alignmentGuide(.leading, computeValue: { d in
                        if (abs(width - d.width) > g.size.width)
                        {
                            width = 0
                            height -= maxHeight
                            maxHeight = .zero
                        }
                        if d.height > maxHeight {
                            maxHeight = d.height
                        }
                        let result = width
                        if self.palavras[index].id == self.palavras.last?.id {
                            width = 0 //last item
                        } else {
                            width -= d.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: {d in
                        let result = height
                        if self.palavras[index].id == self.palavras.last?.id {
                            height = 0 // last item
                        }
                        return result
                    })
            }
        }.background(viewHeightReader($totalHeight))
    }

    private func item(for text: String, size: Float) -> some View {
        WordView(word: text, size: size).fixedSize()
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
}

struct TesteView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone XR"], id: \.self) { deviceName in
            WordGraphView(text: "Mindset Mindset Mindset Mindset Mindset Mindset Mindset Networking Networking Networking Players Players Players Players Believe Believe Believe Work Work Work Business Stonks Stonks Stonks Stonks Top Antenado MenteAberta Suce$$o Power Power Power Power cr14t1v1d4d3 Otimista Realizador Autodeterminado Autoconfiança Inovação Inovação Inovação Originalidade Diferente Diferencial Diferencial Diferencial Valores Propósito Propósito Propósito Propósito Progresso Progresso Progresso Progresso Metas Metas Metas Potencial Ideia Lucro Dinheiro Superávit Superávit Superávit Superávit Sonhos Sonhos  Falhar Sacrifícios Fluxo Conquista Aventura Oportunidades Persistência Disciplina Inspiração Energia Ação Liderança Liderança Liderança Liderança Resultados Resultados Resultados Crescimento Performance FOCO FOCO FOCO FOCO FOCO Growth Growth Growth Growth Atitudes Atitudes Valores Orgulho Moral Produtividade Produtividade Produtividade Produtividade Produtividade Produtividade Equipe FalheRápido Feedback Obstáculos Garra Garra Perspectivas Desafios Desafios Confiança Confiança Goal Impacto Impacto Impacto")
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}
