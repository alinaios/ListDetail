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
    
    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .loading:
            ProgressView()
        case .loaded(let model):
            detailView(model: model)
        case .error(let error):
            errorView(error: error)
        }
    }
    
    private func detailView(model: FeedProperty) -> some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    imageView(imageURL: model.image)
                }
                VStack(alignment: .leading, spacing: 10) {
                    if let street = model.streetAddress {
                        Text(street)
                            .font(.title2)
                            .bold()
                    }
                    
                    Text(model.municipalityArea)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    if let askingPrice = model.askingPrice {
                        Text(askingPrice)
                            .font(.body)
                            .bold()
                    }
                    
                    Spacer()
                    
                    if let info = model.description {
                        Text(info)
                            .font(.body)
                    }
                    
                    Spacer()
                    
                    if let livingArea = model.livingArea {
                        Text("Living area: \(livingArea)")
                            .font(.body)
                            .bold()
                    }
                    
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
            }
            .padding()
        }
    }

    private func imageView(imageURL: URL) -> some View{
        AsyncImage(url: imageURL) { phase in
            switch phase {
            case .success(let image):
                image.resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity, maxHeight: 250)
                    .cornerRadius(4)
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
