//
//  File.swift
//  SampleListDetail
//
//  Created by AH on 2024-05-05.
//

import SwiftUI

struct DetailPropertyView: View {
    @ObservedObject var viewModel: DetailViewModel

    var body: some View {
        content.onAppear {
            viewModel.send(event: .onAppear)
        }
    }
    
    private var content: some View {
        switch viewModel.state {
        case .loading:
            return ProgressView().eraseToAnyView()
        case .loaded(let model):
            return detailView(model: model).eraseToAnyView()
        case .error(let error):
            return errorView(error: error).eraseToAnyView()
        }
    }
    
    private func detailView(model: FeedProperty) -> some View  {
        ScrollView {
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
                    if let askingPrice = model.askingPrice {
                        Text(askingPrice)
                            .font(.body)
                            .bold()
                    }
                    
                    if let info = model.description {
                        Text(info)
                            .font(.body)
                    }
                    
                    if let livingArea = model.livingArea {
                        Text("Living area: \(livingArea)")
                            .font(.body)
                            .bold()
                    }
                    Spacer()
                    
                    if let rooms = model.numberOfRooms {
                        Text("Number of rooms: \(rooms)")
                            .font(.body)
                            .bold()
                    }
                    if let patio = model.patio {
                        Text("Patio: \(patio)")
                            .font(.body)
                            .bold()
                    }
                    if let daysSince = model.daysSincePublish {
                        Text("Days since publish: \(daysSince)")
                            .font(.body)
                            .bold()
                    }
                }
                Spacer()
            }.padding()
        }
    }
    
    private func imageView(imageURL: URL) -> some View{
        AsyncImage(url: imageURL) { phase in
            switch phase {
            case .success(let image):
                image.resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity, maxHeight: 180)
                    .clipped()
            default:
                Image(systemName: "globe")
            }
        }
    }
    
    private func errorView(error: Error) -> some View {
        VStack(alignment: .center, spacing: 12, content: {
            Text("Failed to load data." )
            Button("Retry") {
                viewModel.send(event: .onAppear)
            }
        }).padding()
    }
}
