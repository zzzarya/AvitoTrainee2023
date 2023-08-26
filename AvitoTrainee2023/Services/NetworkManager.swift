//
//  NetworkManager.swift
//  AvitoTrainee2023
//
//  Created by Антон Заричный on 26.08.2023.
//

import Foundation

enum URLs: String {
	case mainUrl = "https://www.avito.st/s/interns-ios/main-page.json"
	case detailUrl = "https://www.avito.st/s/interns-ios/details/"
}

enum NetworkError: Error {
	case invalidURL
	case noData
	case decodingError
	case responseError
}

final class NetworkManager: IMainPageWorker {
	static let shared = NetworkManager()

	private init() {}

	func fetch<T: Decodable>(dataType: T.Type, from url: String?, completion: @escaping(Result<T, NetworkError>) -> Void) {
		guard let url = URL(string: url ?? "") else {
			completion(.failure(.invalidURL))
			return
		}

		URLSession.shared.dataTask(with: url) { data, response, error in
			guard let data = data else {
				completion(.failure(.noData))
				return
			}

			guard let response = response as? HTTPURLResponse else { return }
			if response.statusCode != 200 {
				completion(.failure(.responseError))
			}

			do {
				let decoder = JSONDecoder()
				decoder.keyDecodingStrategy = .convertFromSnakeCase

				let type = try decoder.decode(T.self, from: data)

				completion(.success(type))

			} catch {
				completion(.failure(.decodingError))
			}
		}.resume()
	}
}
