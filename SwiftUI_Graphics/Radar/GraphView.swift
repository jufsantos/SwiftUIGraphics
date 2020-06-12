//
//  AxisView.swift
//  SwiftUI_Graphics
//
//  Created by Leonardo Oliveira on 11/06/20.
//  Copyright © 2020 Luiza Fattori. All rights reserved.
//

import SwiftUI

struct GraphView: View {
    
    var color: Color
    var components: [AxisComponent]
    var elements: [GraphElement]
    @State var center: CGPoint = .zero
    let axisRadius: Double = 150
    
    var degreeInterval: Double {
        return (Double.pi * 2) / Double(components.count)
    }
    
    init(color: Color = .random(), _ components: [AxisComponent], _ elements: [GraphElement]) {
        self.components = components
        self.color = color
        self.elements = elements
    }
    
    func findPoint(_ value: Double, in axis: AxisComponent) -> CGPoint? {
        if let index = components.firstIndex(of: axis) {
            
            let radius = min(value, axis.max) / max(axis.max, 0.1) * axisRadius
            let radians = (Double(index) + 1) * degreeInterval
            
            return center.findPointIn(radius: radius, radians: radians)
        }
        
        return nil
        
    }
    
    var body: some View {
        ZStack {
            GeometryReader { geoProxy in
                ForEach(0 ..< self.components.count) { (index) in
                    
                    ZStack {
                        
                        LineView(color: self.color) { () -> [CGPoint] in
                            self.center = geoProxy.center()
                            
                            let interval = self.degreeInterval * Double(index + 1)
                            
                            let nextPoint = self.center.findPointIn(radius: self.axisRadius, radians: interval)
                            
                            return [self.center, nextPoint]
                        }
                        
                        Text("\(self.components[index].subtitle)")
                            .modifier(SubtitleInGeoProxyModifier(geoProxy, radians: self.degreeInterval*Double(index+1)))
                        
                        ForEach(0 ..< self.elements.count) {
                            (index) in
                            LineView(color: self.elements[index].color, axisView: self, axisComponents: self.components, values: self.elements[index].values)
                        }
                    }
                }
            }
            
            VStack {
                Spacer()
                ForEach(self.elements, id: \.self) { (element) in
                    Text(element.subtitle)
                        .foregroundColor(element.color)
                }
            }
        }
    }
}

struct SubtitleInGeoProxyModifier: ViewModifier {
    var geoProxy: GeometryProxy
    var radians: Double
    init(_ geoProxy: GeometryProxy, radians: Double) {
        self.geoProxy = geoProxy
        self.radians = radians
    }
    func body(content: Content) -> some View{
        content.position(geoProxy.center().findPointIn(radius: 175, radians: self.radians))
    }
    
}

#if DEBUG
struct GraphView_Previews: PreviewProvider {
    static var previews: some View {
        GraphView(color: .gray,
          [
            AxisComponent(subtitle: "Mundiais", max: 3.5),
            AxisComponent(subtitle: "Libertadores", max: 3.5),
            AxisComponent(subtitle: "BR-B", max: 2.5)
          ],
          [
            GraphElement(subtitle: "São Paulo", values: [3, 3, 0], color: .red),
            GraphElement(subtitle: "Palmeiras", values: [0, 1, 2], color: .green),
            GraphElement(subtitle: "Corithians", values: [2, 1, 1], color: .gray),
        ])
    }
}
#endif
