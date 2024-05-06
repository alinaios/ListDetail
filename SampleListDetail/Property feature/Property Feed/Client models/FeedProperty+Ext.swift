//
//  FeedProperty+Ext.swift
//  SampleListDetail
//
//  Created by AH on 2024-05-03.
//

import Foundation

/// These extentions will be used for previews and snapshot testing
///
extension FeedProperty {
    /// mock for a property of a type *HighlightedProperty*
    static func mockHighlightedProperty() -> FeedProperty {
        return FeedProperty(type: .highlightedProperty,
                            id: "1234567890",
                            askingPrice: 2650000,
                            municipality: "Gällivare kommun",
                            area: "Heden",
                            livingArea: 120,
                            numberOfRooms: 5,
                            streetAddress: "Mockvägen 1",
                            image: "https://upload.wikimedia.org/wikipedia/commons/thumb/5/5b/Hus_i_svarttorp.jpg/800px-Hus_i_svarttorp.jpg")
    }
    
    /// mock for a property of a type *Property*
    static func mockProperty() -> FeedProperty {
        return FeedProperty(type: .property,
                            id: "1234567891",
                            askingPrice: 6950000,
                            municipality: "Stockholm",
                            area: "Nedre Gärdet",
                            livingArea: 85,
                            numberOfRooms: 3,
                            streetAddress: "Mockvägen 2",
                            image: "https://upload.wikimedia.org/wikipedia/commons/8/8f/Arkitekt_Peder_Magnussen_hus_H%C3%B8nefoss_HDR.jpg",
                            monthlyFee: 3498,
                            ratingFormatted: "4.5/5",
                            averagePrice: 50100)
    }
    
    /// mock for a property of a type *Area*
    static func mockArea() -> FeedProperty {
        return FeedProperty(type: .area,
                            id: "1234567892",
                            area: "Stockholm",
                            image: "https://i.imgur.com/v6GDnCG.png",
                            ratingFormatted: "4.5/5",
                            averagePrice: 50100)
    }
}

