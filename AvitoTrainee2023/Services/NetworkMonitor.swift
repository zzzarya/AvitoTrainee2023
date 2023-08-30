//
//  NetworkMonitor.swift
//  AvitoTrainee2023
//
//  Created by Антон Заричный on 30.08.2023.
//

import UIKit
import Network

final class NetworkMonitor {
	static let shared = NetworkMonitor()

	private let queue = DispatchQueue.global()
	private let monitor = NWPathMonitor()

	private init() {}

	func startMonitoring(completion: @escaping(Bool) -> Void) {
		monitor.start(queue: queue)
		monitor.pathUpdateHandler = { path in
			DispatchQueue.main.async {
				completion(path.status == .satisfied)
			}
		}
	}

	func stopMonitoring() {
		monitor.cancel()
	}
}
