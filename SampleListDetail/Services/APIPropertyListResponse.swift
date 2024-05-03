//
//  APIPropertyResponse.swift
//  SampleListDetail
//
//  Created by AH on 2024-05-03.
//

import Foundation


struct APIPropertyListResponse: Codable {
    let items: [Property]
}

struct Property: Codable {
    let type, id: String
    let askingPrice: Int?
    let municipality: String?
    let area: String
    let daysSincePublish, livingArea, numberOfRooms: Int?
    let streetAddress: String?
    let image: String
    let monthlyFee: Int?
    let ratingFormatted: String?
    let averagePrice: Int?
}
