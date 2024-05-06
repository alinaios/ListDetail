//
//  FeedPropertyMapper.swift
//  SampleListDetail
//
//  Created by AH on 2024-05-03.
//

import Foundation

enum FeedPropertyMapper {
    private struct Root: Decodable {
        let items: [APIProperty]
        
        var feed: [FeedProperty] {
            return items.map { $0.item }
        }
    }
    
    private struct APIProperty: Decodable {
        let type: PropertyType
        let id: String
        let askingPrice: Int?
        let municipality: String?
        let area: String
        let daysSincePublish, livingArea, numberOfRooms: Int?
        let streetAddress: String?
        let image: String
        let monthlyFee: Int?
        let ratingFormatted: String?
        let averagePrice: Int?
        let description: String?
        let patio: String?
        
        enum PropertyType: String, Codable {
            case HighlightedProperty
            case Property
            case Area
        }
        
        private func mapPropertyType(_ propertyType: PropertyType) -> FeedPropertyType {
            return FeedPropertyType(rawValue: propertyType.rawValue.lowercasedFirstCharacter()) ?? .area
        }
        
        var item: FeedProperty {
            return FeedProperty(type: mapPropertyType(type),
                                id: id,
                                askingPrice: askingPrice,
                                municipality: municipality,
                                area: area, livingArea: livingArea,
                                numberOfRooms: numberOfRooms,
                                streetAddress: streetAddress,
                                image: image,
                                monthlyFee: monthlyFee,
                                ratingFormatted: ratingFormatted,
                                averagePrice: averagePrice,
                                description: description,
                                patio: patio,
                                daysSincePublish: daysSincePublish)
        }
    }
    
    private static var OK_200: Int { return 200 }
    
    static func map(_ data: Data, from response: HTTPURLResponse) -> PropertyFeedLoader.FeedResult {
        guard response.statusCode == OK_200,
              let root = try? JSONDecoder().decode(Root.self, from: data) else {
            return .failure(RemoteFeedLoader.Error.invalidData)
        }
        return .success(root.feed)
    }
    
    static func mapSingleProperty(_ data: Data, from response: HTTPURLResponse) -> PropertyFeedLoader.DetailResult {
        guard response.statusCode == OK_200,
              let root = try? JSONDecoder().decode(APIProperty.self, from: data) else {
            return .failure(RemoteFeedLoader.Error.invalidData)
        }
        return .success(root.item)
    }
}

extension String {
    func lowercasedFirstCharacter() -> String {
        guard let firstCharacter = self.first else { return self }
        return String(firstCharacter).lowercased() + dropFirst()
    }
}
