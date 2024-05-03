//
//  RemoteFeedLoader.swift
//  SampleListDetail
//
//  Created by AH on 2024-05-03.
//

import Foundation

public final class RemoteFeedLoader: PropertyFeedLoader {
    private let url: URL
    private let client: HTTPClient

    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }

    public init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }

    public func load(completion: @escaping (PropertyFeedLoader.Result) -> Void) {
        client.get(from: url) { [weak self] response in
            guard self != nil else { return }

            switch response {
            case let .success((data, response)):
                completion(FeedPropertyMapper.map(data, from: response))
            case .failure:
                completion(.failure(RemoteFeedLoader.Error.connectivity))
            }
        }
    }
}
