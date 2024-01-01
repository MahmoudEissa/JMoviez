//
//  JZBaseViewModel.swift
//  JMoveiz
//
//  Created by Mahmoud Eissa on 12/31/23.
//

import Foundation
import Combine

class JZBaseViewModel: ObservableObject {
    // MARK: - Output
    @Published var isLoading = false
    @Published var error: Error?
}
