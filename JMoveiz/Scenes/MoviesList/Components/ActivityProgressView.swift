//
//  ActivityProgressView.swift
//  JMoveiz
//
//  Created by Mahmoud Eissa on 12/31/23.
//

import SwiftUI


struct ActivityProgressView: View {
    
    @Binding var isLoading: Bool
    
    var body: some View {
        if isLoading {
            ProgressView()
                .controlSize(.large)
                .tint(.white)
        }
    }
}
