//
//  SearchView.swift
//  JMoveiz
//
//  Created by Mahmoud Eissa on 12/31/23.
//

import SwiftUI

struct SearchView: View {

    @Binding var text: String

    let placeholder: String

    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(.gray.opacity(0.4))
            }
            TextField("", text: $text)
                .foregroundColor(.white)
        }
        .cornerRadius(4)
        .padding(.all, 8)
        .background(Color("appGray"))
        .clipped()
        .padding(8)
    }
}
