//
//  PropertyFeedLoader.swift
//  SampleListDetail
//
//  Created by AH on 2024-05-03.
//

import Foundation

public protocol PropertyFeedLoader {
    typealias FeedResult = Swift.Result<[FeedProperty], Error>
    typealias DetailResult = Swift.Result<FeedProperty, Error>
    
    func load(completion: @escaping (FeedResult) -> Void)
    
    func load(completion: @escaping (DetailResult) -> Void)
}
