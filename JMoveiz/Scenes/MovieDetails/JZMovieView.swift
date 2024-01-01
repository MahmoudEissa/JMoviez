//
//  JZMovieView.swift
//  JMoveiz
//
//  Created by Mahmoud Eissa on 12/31/23.
//

import SwiftUI
import Kingfisher

struct JZMovieView: View {
    
    let movie: JZMovie
    
    private enum CoordinateSpaces {
        case scrollView
    }
    
    var body: some View {
        ScrollView {
            ParallaxHeader(coordinateSpace: CoordinateSpaces.scrollView, defaultHeight: 500) {
                KFImage(.init(string: movie.imageUrl))
                    .fade(duration: 0.25)
                    .resizable()
                    .scaledToFill()
            }
            HStack {
                VStack(alignment: .leading) {
                    Spacer(minLength: 16)
                    Text((movie.title ?? "") + " (\(movie.year ?? ""))")
                        .foregroundColor(.white)
                        .font(.system(size: 24, weight: .bold))
                    Spacer()
                    Text(movie.overview ?? "")
                        .foregroundColor(.white)
                }
                Spacer()
            }
            .padding(8)
            .background(.black)
        }
        .background(.black)
        .scrollIndicators(.hidden)
        .coordinateSpace(name: CoordinateSpaces.scrollView)
        .edgesIgnoringSafeArea(.top)
        .toolbarBackground(.hidden, for: .navigationBar)
    }
}
