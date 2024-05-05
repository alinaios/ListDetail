//
//  CompositionRoot.swift
//  SampleListDetail
//
//  Created by AH on 2024-05-05.
//

import Foundation


let client = URLSessionHTTPClient(session: URLSession.shared)
let feedService = RemoteFeedLoader(url: URL(string: "https://pastebin.com/raw/nH5NinBi")!, client: client)
let detailService = RemoteFeedLoader(url: URL(string: "https://pastebin.com/raw/uj6vtukE")!, client: client)

let propertyViewModel = PropertyListViewModel(service: feedService)
let detailViewModel = DetailViewModel(service: detailService)
