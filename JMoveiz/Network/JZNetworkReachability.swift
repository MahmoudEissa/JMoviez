//
//  JZNetworkReachability.swift
//  JMoveiz
//
//  Created by Mahmoud Eissa on 12/31/23.
//

import Network
import SwiftUI

protocol JZNetworkReachabilityProtocol {
    var isConnected: Bool { get set }
    var isConnectedPublisher: Published<Bool>.Publisher { get }
}

class JZNetworkReachability: ObservableObject, JZNetworkReachabilityProtocol {
    
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "Monitor")

    @Published var isConnected: Bool = false
    
    var isConnectedPublisher: Published<Bool>.Publisher { return  $isConnected }


    init() {
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.isConnected = path.status == .satisfied
            }
        }
        monitor.start(queue: queue)
    }
}
