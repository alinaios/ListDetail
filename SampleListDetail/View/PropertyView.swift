//
//  PropertyView.swift
//  SampleListDetail
//
//  Created by AH on 2024-05-03.
//

import SwiftUI

struct PropertyView: View {
    @State var viewModel: FeedProperty

    var body: some View {
        propertyView
    }
    
    private var propertyView: some View {
        VStack(alignment:. leading, spacing: 20) {
            HStack {
                imageView(imageURL: viewModel.image)
                    .border(viewModel.type == .highlightedProperty ? Color.yellow: Color.clear, width: 4)
            }
            VStack(alignment:. leading, spacing: 10) {
                if let street = viewModel.streetAddress {
                    Text(street)
                    .font(.title2)
                    .bold()
                }
            if let municipalityArea = viewModel.municipalityArea {
                Text(municipalityArea)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
                HStack {
                    if let askingPrice = viewModel.askingPrice {
                        Text(askingPrice)
                            .font(.body)
                            .bold()
                    }
                    Spacer()
                    
                    if let livingArea = viewModel.livingArea {
                        Text(livingArea)
                            .font(.body)
                            .bold()
                    }
                    Spacer()

                    if let rooms = viewModel.numberOfRooms {
                        Text(rooms)
                            .font(.body)
                            .bold()
                    }
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
        PropertyView(viewModel: FeedProperty.mockHighlightedProperty())
    }
}
