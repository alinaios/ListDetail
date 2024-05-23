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

import Foundation

public struct FeedProperty: Hashable, Identifiable {
    public let type: FeedPropertyType
    public let id: String
    public let askingPrice: String?
    public let municipalityArea: String
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
        
        self.askingPrice = askingPrice.map { NumberFormatter.spaceGroupingFormatter().string(from: NSNumber(value: $0))! + " SEK" }
        
        self.municipalityArea = municipality.map { "\(area), \($0)" } ?? area
        
        self.livingArea = livingArea.map { "\($0) m²" }
        
        self.numberOfRooms = numberOfRooms.map { "\($0) rooms" }
        
        self.streetAddress = streetAddress
        
        self.image = URL(string: image) ?? {
            fatalError("Invalid URL string: \(image)")
        }()
        
        self.monthlyFee = monthlyFee
        
        self.ratingFormatted = ratingFormatted.map { "Rating: \($0)" }
        
        self.averagePrice = averagePrice.map { NumberFormatter.spaceGroupingFormatter().string(from: NSNumber(value: $0))! + " m²" }
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
