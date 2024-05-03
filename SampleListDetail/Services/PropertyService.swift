//
//  PropertyService.swift
//  SampleListDetail
//
//  Created by AH on 2024-05-03.
//

import Foundation
import Combine

final class PropertyService: DataFetchManager {
    func call(with parameters: PropertyListParameter) -> AnyPublisher<APIPropertyListResponse, Error> {
        return self.execute(parameters, errorType: Error.self)
    }
}
