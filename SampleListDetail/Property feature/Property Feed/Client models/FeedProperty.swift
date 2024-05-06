//
//  FeedProperty.swift
//  SampleListDetail
//
//  Created by AH on 2024-05-03.
//

import Foundation

/// FeedPropertyType is a presentation model for PropertyView helping
///    -keeps APIPropery private and decopled from client code
///    -has additonal formatting logic ready to be used by view.
///
public enum FeedPropertyType: String, Codable {
    case highlightedProperty
    case property
    case area
}

public struct FeedProperty: Hashable, Identifiable {
    public let type: FeedPropertyType
    public let id: String
    public let askingPrice: String?
    public let municipalityArea: String?
    public let livingArea: String?
    public let numberOfRooms: String?
    public let streetAddress: String?
    public let image: URL
    public let monthlyFee: Int?
    public let ratingFormatted: String?
    public let averagePrice: String?
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
        self.description = description
        self.patio = patio
        self.daysSincePublish = daysSincePublish
        
        if let intValue = askingPrice, let formattedPrice = NumberFormatter.spaceGroupingFormatter().string(from: NSNumber(value: intValue)) {
            self.askingPrice = "\(formattedPrice) SEK"
        } else {
            self.askingPrice = nil
        }
        if let municipality = municipality {
            self.municipalityArea = "\(area), \(municipality)"
        } else {
            municipalityArea = area
        }
        if let intValue = livingArea {
            self.livingArea = "\(intValue) m²"
        } else {
            self.livingArea = nil
        }
        
        if let intValue = numberOfRooms {
            self.numberOfRooms = "\(intValue) rooms"
        } else {
            self.numberOfRooms = nil
        }
        
        self.streetAddress = streetAddress
        self.image = URL(string: image)!
        self.monthlyFee = monthlyFee
        
        if let rating = ratingFormatted {
            self.ratingFormatted = "Rating: \(rating)"
        } else {
            self.ratingFormatted = nil
        }
        if let intValue = averagePrice, let formattedPrice = NumberFormatter.spaceGroupingFormatter().string(from: NSNumber(value: intValue)) {
            self.averagePrice = "Average price: \(formattedPrice) m²"
        } else {
            self.averagePrice = nil
        }
    }
}

extension NumberFormatter {
    static func spaceGroupingFormatter() -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        return formatter
    }
}
