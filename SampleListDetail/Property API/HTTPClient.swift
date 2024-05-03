//
//  HTTPClient.swift
//  SampleListDetail
//
//  Created by AH on 2024-05-03.
//

import Foundation

public protocol HTTPClient {
    typealias Result = Swift.Result<(Data, HTTPURLResponse), Error>

    func get(from url: URL, completion: @escaping (Result) -> Void)
}
