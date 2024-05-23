//
//  FeedProperty.swift
//  SampleListDetail
//
//  Created by AH on 2024-05-03.
//

import Foundation

/// FeedPropertyType is a presentation model for PropertyView helping
///    -keeps APIProperty private and decoupled from client code
///    -has additional formatting logic ready to be used by view.
///

public struct FeedProperty: Hashable, Identifiable {
    public let type: FeedPropertyType
    public let id: String
    public let askingPrice: Int?
    public let municipality: String?
    public let area: String
    public let livingArea: Int?
    public let numberOfRooms: Int?
    public let streetAddress: String?
    public let image: URL
    public let monthlyFee: Int?
    public let ratingFormatted: String?
    public let averagePrice: Int?
    public let description: String?
    public let patio: String?
    public let daysSincePublish: Int?

    public init(type: FeedPropertyType,
                id: String,
                askingPrice: Int? = nil,
                municipality: String? = nil,
                area: String,
                livingArea: Int? = nil,
                numberOfRooms: Int? = nil,
                streetAddress: String? = nil,
                image: String,
                monthlyFee: Int? = nil,
                ratingFormatted: String? = nil,
                averagePrice: Int? = nil,
                description: String? = nil,
                patio: String? = nil,
                daysSincePublish: Int? = nil) {
        
        self.type = type
        self.id = id
        self.askingPrice = askingPrice
        self.municipality = municipality
        self.area = area
        self.livingArea = livingArea
        self.numberOfRooms = numberOfRooms
        self.streetAddress = streetAddress
        self.image = URL(string: image)!
        self.monthlyFee = monthlyFee
        self.ratingFormatted = ratingFormatted
        self.averagePrice = averagePrice
        self.description = description
        self.patio = patio
        self.daysSincePublish = daysSincePublish
    }
}

extension FeedProperty {
    var formattedAskingPrice: String? {
        askingPrice.map { "\(NumberFormatter.spaceGroupingFormatter().string(from: NSNumber(value: $0))!) SEK" }
    }
    
    var formattedMunicipalityArea: String {
        municipality.map { "\(area), \($0)" } ?? area
    }
    
    var formattedLivingArea: String? {
        livingArea.map { "\($0) m²" }
    }
    
    var formattedNumberOfRooms: String? {
        numberOfRooms.map { "\($0) rooms" }
    }
    
    var formattedRating: String? {
        ratingFormatted.map { "Rating: \($0)" }
    }
    
    var formattedAveragePrice: String? {
        averagePrice.map { "Average price: \(NumberFormatter.spaceGroupingFormatter().string(from: NSNumber(value: $0))!) m²" }
    }
}

public enum FeedPropertyType: String, Codable {
    case highlightedProperty
    case property
    case area
}

extension NumberFormatter {
    static func spaceGroupingFormatter() -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        return formatter
    }
}
