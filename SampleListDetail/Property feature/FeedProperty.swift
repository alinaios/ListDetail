//
//  FeedProperty.swift
//  SampleListDetail
//
//  Created by AH on 2024-05-03.
//

import Foundation

public enum FeedPropertyType: String, Codable {
    case highlightedProperty
    case property
    case area
}

public struct FeedProperty: Hashable {
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
    
    public init(type: FeedPropertyType, id: String, askingPrice: Int?, municipality: String?, area: String, livingArea: Int?, numberOfRooms: Int?, streetAddress: String?, image: String, monthlyFee: Int?, ratingFormatted: String?, averagePrice: Int?) {
        
        self.type = type
        self.id = id
        if let intValue = askingPrice {
            self.askingPrice = "\(intValue) SEK"
        } else {
            self.askingPrice = nil
        }
        if let municipality = municipality {
            self.municipalityArea = "\(municipality), \(area)"
        } else {
            municipalityArea = nil
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
        self.ratingFormatted = ratingFormatted
        if let intValue = averagePrice {
            self.averagePrice = "\(intValue) SEK"
        } else {
            self.averagePrice = nil
        }
    }
   
}
extension FeedProperty {
    static func mockHighlightedProperty() -> FeedProperty {
        return FeedProperty(type: .highlightedProperty,
                            id: "123",
                            askingPrice: 200000,
                            municipality: "Stockholm",
                            area: "Nedre Gärdet",
                            livingArea: 125,
                            numberOfRooms: 5,
                            streetAddress: "Gällivare kommun",
                            image: "https://upload.wikimedia.org/wikipedia/commons/thumb/5/5b/Hus_i_svarttorp.jpg/800px-Hus_i_svarttorp.jpg",
                            monthlyFee: 4100,
                            ratingFormatted: "4.5/5",
                            averagePrice: 50100)
    }
}



