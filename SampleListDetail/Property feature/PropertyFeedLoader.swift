//
//  PropertyFeedLoader.swift
//  SampleListDetail
//
//  Created by AH on 2024-05-03.
//

import Foundation

public protocol PropertyFeedLoader {
    typealias Result = Swift.Result<[FeedProperty], Error>

    func load(completion: @escaping (Result) -> Void)
}
