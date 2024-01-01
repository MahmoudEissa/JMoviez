//
//  JZPagerViewModel.swift
//  JMoveiz
//
//  Created by Mahmoud Eissa on 12/31/23.
//

import Foundation
import Combine

class JZPagerViewModel<Elemenet>: JZBaseViewModel where Elemenet: Identifiable {
    // MARK: - Output
    @Published var items: [Elemenet] = []
        
    // MARK: - Configuration
    private let itemsFromEndThreshold = 5
    
    // MARK: - Pagination
    var totalItemsAvailable = 0
    var totalPagesAvailable = 0
    var currentPage = 0
    
    func requestInitialSetOfItems() {
        currentPage = 0
        items = []
        totalItemsAvailable = 0
        totalPagesAvailable = 0
        requestItems(page: 1)
    }
    
    func onItemAppear(_ item: Elemenet) {
        guard !isLoading else {
            return
        }
        
        let itemsLoadedCount = items.count
        
        guard moreItemsRemaining(itemsLoadedCount, totalItemsAvailable) else {
            return
        }
        
        guard let index = items.firstIndex(where: { $0.id == item.id }) else {
            return
        }
        
        guard thresholdMeet(itemsLoadedCount, index) else {
            return
        }

        requestItems(page: currentPage + 1)
    }
    
    func requestItems(page: Int) { }
    
    func thresholdMeet(_ itemsLoadedCount: Int, _ index: Int) -> Bool {
        return (itemsLoadedCount - index) == itemsFromEndThreshold
    }
    
    func moreItemsRemaining(_ itemsLoadedCount: Int, _ totalItemsAvailable: Int) -> Bool {
        return itemsLoadedCount < totalItemsAvailable && currentPage < totalPagesAvailable
    }
}
