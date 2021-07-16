//
//  SectionRowView.swift
//  FourImageOneWord
//
//  Created by Yasemin SALAN on 1.07.2021.
//

import SwiftUI

struct SectionRowView: View {
    var model : ModelJson
    var body: some View {
        HStack {
            
            Text(model.section)
                .font(.largeTitle)
                .foregroundColor(.red)
            
            Spacer()
        }
    }
}

struct SectionRowView_Previews: PreviewProvider {
    static var previews: some View {
        SectionRowView(model: models[0])
            .previewLayout(.fixed(width: 300, height: 70))
    }
}
