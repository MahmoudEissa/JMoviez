//
//  JZMockNetworkReachability.swift
//  JMoveizTests
//
//  Created by Mahmoud Eissa on 12/31/23.
//

import Foundation
@testable import JMoveiz

class JZMockNetworkReachability: JZNetworkReachabilityProtocol {
    @Published var isConnected: Bool = true
    var isConnectedPublisher: Published<Bool>.Publisher { return  $isConnected }
}
