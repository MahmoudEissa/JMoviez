//
//  MoviesListViewModel.swift
//  JMoveiz
//
//  Created by Mahmoud Eissa on 12/30/23.
//
import Foundation
import Combine

class JZMoviesListViewModel: JZPagerViewModel<JZMovie> {
    // MARK: - Input
    @Published var text = ""
    @Published var genreIds: Set<Int> = .init()
    
    // MARK: 3 Services
    private var service: JZMoviesListServiceProtocol
    private let reachability: JZNetworkReachabilityProtocol
    private var cancelBag = Set<AnyCancellable>()

    init(service: JZMoviesListServiceProtocol, reachability: JZNetworkReachabilityProtocol) {
        self.service = service
        self.reachability = reachability
        super.init()
        configureBinding()
    }
    
    private func configureBinding() {
        $text.dropFirst()
            .debounce(for: .milliseconds(700), scheduler: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.requestInitialSetOfItems()
            }
            .store(in: &cancelBag)
        
        reachability.isConnectedPublisher
            .removeDuplicates()
            .dropFirst()
            .sink { [weak self] isConnected in
                self?.service.onStatusChanged(isConnected: isConnected)
                self?.requestInitialSetOfItems()
            }
            .store(in: &cancelBag)
    }
    
    override func requestItems(page: Int) {
        isLoading = true
        error = nil
        service.getMovies(page: page, query: text, genreIds: Array(genreIds))
            .sink { [weak self] response in
                guard case .failure(let error) = response else {
                    return
                }
                self?.error = error
            } receiveValue: { [weak self] response in
                self?.totalItemsAvailable = response.totalResults
                self?.totalPagesAvailable = response.totalPages
                self?.currentPage = response.page
                self?.items.append(contentsOf: response.results)
                self?.isLoading = false
            }
            .store(in: &cancelBag)
    }
}
