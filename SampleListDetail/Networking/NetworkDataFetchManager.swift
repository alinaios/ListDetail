//
//  NetworkDataFetchManager.swift
//  SampleListDetail
//
//  Created by AH on 2024-05-03.
//

import Combine
import Foundation

final class NetworkDataFetchManager {

    func fetch<T: Decodable, R: Routing>(_ routing: R) -> AnyPublisher<T, Error> {
        let urlSession = URLSession(configuration: .default)
#if DEBUG
        print(routing.urlRequest ?? "urlRequest is nil")
#endif
        guard let url = routing.urlRequest else {
            fatalError("Could not create url")
        }

        return urlSession.dataTaskPublisher(for: url)
            .mapError { $0 as Error }
            .map { $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
