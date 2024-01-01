//
//  JMoveizApp.swift
//  JMoveiz
//
//  Created by Mahmoud Eissa on 12/29/23.
//

import SwiftUI

@main
struct JMoveizApp: App {
    var body: some Scene {
        WindowGroup {
            JZMoviesListView(viewModel: JZMoviesListViewModel(service: JZMoviesListService(),
                                                              reachability: JZNetworkReachability()))
        }
    }
}
