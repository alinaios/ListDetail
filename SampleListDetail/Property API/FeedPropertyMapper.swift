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
        
        enum PropertyType: String, Codable {
            case HighlightedProperty
            case Property
            case Area
        }
        
        func mapPropertyType(_ propertyType: PropertyType) -> FeedPropertyType {
            return FeedPropertyType(rawValue: propertyType.rawValue.lowercased()) ?? .property
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
                                averagePrice: averagePrice)
        }
    }
    
    private static var OK_200: Int { return 200 }
    
    static func map(_ data: Data, from response: HTTPURLResponse) -> PropertyFeedLoader.Result {
        guard response.statusCode == OK_200,
              let root = try? JSONDecoder().decode(Root.self, from: data) else {
            return .failure(RemoteFeedLoader.Error.invalidData)
        }
        return .success(root.feed)
    }
}
