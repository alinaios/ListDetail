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
            VStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: 12, content: {
                        ForEach(list) { currentItem in
                            elementView(property: currentItem)
                        }
                    }).padding()
                }
            }
        }
    }
    
    
    private func elementView(property: FeedProperty) -> some View {
        NavigationLink {
            EmptyView()
        } label: {
            PropertyView(model: property)
        }
    }

    private func emptyResultsView() -> some View {
        Text("No items to display").padding()
    }

    private func errorView(error: Error) -> some View {
        VStack(alignment: .center, spacing: 12, content: {
            Text("Failed to load data. Tap 'Retry' to try again." )
            Button("Retry") {
                viewModel.send(event: .onAppear)
            }
        }).padding()
    }
}

extension View {
    func eraseToAnyView() -> AnyView { AnyView(self) }
}
