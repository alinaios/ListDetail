//
//  DataFetchManager.swift
//  SampleListDetail
//
//  Created by AH on 2024-05-03.
//

import Foundation
import Combine

class DataFetchManager {

    let manager: NetworkDataFetchManager

    init(with fetchManager: NetworkDataFetchManager) {
        manager = fetchManager
    }

    func execute<T: Decodable, R: Routing, E: Error>(_ route: R, errorType: E.Type) -> AnyPublisher<T, Error> {
        return manager.fetch(route)
    }
}
