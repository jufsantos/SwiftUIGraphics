//
//  AxisView.swift
//  SwiftUI_Graphics
//
//  Created by Leonardo Oliveira on 11/06/20.
//  Copyright © 2020 Luiza Fattori. All rights reserved.
//

import SwiftUI

struct AxisComponent {
    
    var subtitle: String
    var scale: Range<Float>
}

struct AxisView: View {
    
    var components: [AxisComponent]
    
    var degreeInterval: Float {
        return (Float.pi * 2) / Float(components.count)
    }
    
    init(components: AxisComponent...) {
        self.components = components
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct AxisView_Previews: PreviewProvider {
    static var previews: some View {
        AxisView()
    }
}
