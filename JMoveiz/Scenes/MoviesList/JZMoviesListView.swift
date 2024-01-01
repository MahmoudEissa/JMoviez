//
//  MoviesListView.swift
//  JMoveiz
//
//  Created by Mahmoud Eissa on 12/30/23.
//

import SwiftUI

struct JZMoviesListView: View {
    
    @ObservedObject private var viewModel: JZMoviesListViewModel
    
    init(viewModel: JZMoviesListViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 8) {
                HeaderText(text: "Watch New Movies", color: Color("appYellow"))
                SearchView(text: $viewModel.text, placeholder: "Search TMDB")
                MoviesListView(viewModel: viewModel)
            }
            .overlay(alignment: .center) {
                ActivityProgressView(isLoading: $viewModel.isLoading)
            }
            .overlay(alignment: .center) {
                if $viewModel.items.isEmpty {
                    Image("box")
                }
            }
            .background(.black)
            .navigationBarHidden(true)
        }
    }
}

private struct MoviesListView: View {

    private let columns = [GridItem(.flexible()), GridItem(.flexible())]

    let viewModel: JZMoviesListViewModel

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 8) {
                ForEach(viewModel.items) { movie in
                    NavigationLink {
                        JZMovieView(movie: movie)
                    } label: {
                        JZMovieCardView.init(movie: movie)
                            .frame(width: UIScreen.main.bounds.width / 2 - 8, height: 300)
                            .clipped()
                            .onAppear {
                                viewModel.onItemAppear(movie)
                            }
                    }
                }
            }
        }
        .padding(8)
        .scrollIndicators(.hidden)
    }
}
