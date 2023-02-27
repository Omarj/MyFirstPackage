//
//  File 4.swift
//  
//
//  Created by Omarj on 27/02/2023.
//

import Foundation
import Network

//This creates a delegate NetworkConnectionDelegate with a networkConnectionDidChange function. The NetworkConnectionManager class sets the delegate to notify the app when the network status changes.
public protocol NetworkConnectionDelegate: AnyObject {
    func networkConnectionDidChange(_ isReachable: Bool)
}

public final class NetworkConnectionManager {
    private let monitor = NWPathMonitor()
    weak var delegate: NetworkConnectionDelegate?
    
    public var isReachable: Bool {
        return monitor.currentPath.status == .satisfied
    }
    
    public init() {
        // Set the path update handler
        monitor.pathUpdateHandler = { [weak self] path in
            print("Network status changed: \(path.status)")
            self?.delegate?.networkConnectionDidChange(path.status == .satisfied)
        }
        // Start the monitor
        let queue = DispatchQueue(label: "NetworkConnectionMonitor")
        monitor.start(queue: queue)
    }
}

