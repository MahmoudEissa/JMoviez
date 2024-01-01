//
//  JZMovieCardView.swift
//  JMoveiz
//
//  Created by Mahmoud Eissa on 12/30/23.
//

import SwiftUI
import Kingfisher

struct JZMovieCardView: View {
    
    let movie: JZMovie
    
    var body: some View {
        ZStack() {
            KFImage(.init(string: movie.thumbUrl))
                .fade(duration: 0.25)
                .placeholder {
                    Color("appGray")
                }
                .frame(height: 300)
        }
        .overlay(alignment: .bottom){
            HStack {
                Spacer()
                VStack(alignment: .center) {
                    Text(movie.title ?? "")
                        .foregroundColor(.white)
                        .lineLimit(2)
                    
                    Text(movie.year ?? "")
                        .foregroundColor(.white)
                }
                Spacer()
            }
            .background(Color("appGray"))
        }
    }
}
