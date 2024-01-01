//
//  HeaderText.swift
//  JMoveiz
//
//  Created by Mahmoud Eissa on 12/31/23.
//

import SwiftUI

struct HeaderText: View {

    let text: String
    let color: Color

    var body: some View {
        Text(text)
            .foregroundColor(color)
            .font(.system(size: 32, weight: .bold))
            .padding(.leading, 8)
    }
}
