//
//  PropertyView.swift
//  SampleListDetail
//
//  Created by AH on 2024-05-03.
//

import SwiftUI

struct PropertyView: View {
    
    @State var model: FeedProperty
    
    var body: some View {
        if model.type == .area {
            areaPropertyView
        } else {
            propertyView
        }
    }
    
    private var propertyView: some View {
        VStack(alignment:. leading, spacing: 20) {
            HStack {
                imageView(imageURL: model.image)
                    .border(model.type == .highlightedProperty ? Color.yellow: Color.clear, width: 4)
            }
            VStack(alignment:. leading, spacing: 10) {
                if let street = model.streetAddress {
                    Text(street)
                    .font(.title2)
                    .bold()
                }
            if let municipalityArea = model.municipalityArea {
                Text(municipalityArea)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
                HStack {
                    if let askingPrice = model.askingPrice {
                        Text(askingPrice)
                            .font(.body)
                            .bold()
                    }
                    Spacer()
                    
                    if let livingArea = model.livingArea {
                        Text(livingArea)
                            .font(.body)
                            .bold()
                    }
                    Spacer()

                    if let rooms = model.numberOfRooms {
                        Text(rooms)
                            .font(.body)
                            .bold()
                    }
                }
            }
        }.padding()
    }
    
    private var areaPropertyView: some View {
        VStack(alignment:. leading, spacing: 20) {
            Text(model.type.rawValue.capitalized)
                .font(.title)
            HStack {
                imageView(imageURL: model.image)
            }
            VStack(alignment:. leading, spacing: 10) {
                if let municipalityArea = model.municipalityArea {
                    Text(municipalityArea)
                    .font(.title3)
                }
                if let rating = model.ratingFormatted {
                    Text(rating).font(.body).bold()
                }
                if let averagePrice = model.averagePrice {
                    Text(averagePrice)
                        .font(.body)
                        .bold()
                }
            }
        }.padding()
    }
    
    private func imageView(imageURL: URL) -> some View{
            AsyncImage(url: imageURL) { phase in
                switch phase {
                case .success(let image):
                    image.resizable()
                        .scaledToFit()
                default:
                    Image(systemName: "globe")
                }
            }
        }
}
struct PropertyView_Previews: PreviewProvider {
    static var previews: some View {
        PropertyView(model: FeedProperty.mockHighlightedProperty())
        PropertyView(model: FeedProperty.mockProperty())
        PropertyView(model: FeedProperty.mockArea())
    }
}
