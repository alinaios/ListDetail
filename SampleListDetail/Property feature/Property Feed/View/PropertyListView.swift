//
//  PropertyListView.swift
//  SampleListDetail
//
//  Created by AH on 2024-05-05.
//

import Foundation
import SwiftUI

struct PropertyListView: View {
    @ObservedObject var viewModel: PropertyListViewModel
    
    var body: some View {
        content.onAppear {
            viewModel.send(event: .onAppear)
        }
    }
    
    private var content: some View {
        switch viewModel.state {
        case .loadingList:
            return ProgressView().eraseToAnyView()
        case .loadedList(let list):
            return loadedListView(list: list).eraseToAnyView()
        case .error(let error):
            return errorView(error: error).eraseToAnyView()
        }
    }
    
    private func loadedListView(list: [FeedProperty]) -> some View {
        return NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20, content: {
                    Spacer()
                    ForEach(list.indices, id: \.self) { index in
                        if index == 0 {
                            NavigationLink(destination: DetailPropertyView(viewModel: detailViewModel)) {
                                elementView(property: list[index])
                            }
                        } else {
                            elementView(property: list[index])
                        }
                    }
                })
            }
        }
    }
    
    private func elementView(property: FeedProperty) -> some View {
        PropertyView(model: property)
    }
    
    private func emptyResultsView() -> some View {
        Text("No items to display").padding()
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

extension View {
    func eraseToAnyView() -> AnyView { AnyView(self) }
}
