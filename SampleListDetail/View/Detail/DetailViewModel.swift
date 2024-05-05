//
//  DetailViewModel.swift
//  SampleListDetail
//
//  Created by AH on 2024-05-05.
//

import Foundation

final class DetailViewModel: ObservableObject {
    @Published private(set) var state = State.loading
    private let service: PropertyFeedLoader
    
    init(service: PropertyFeedLoader) {
        self.service = service
    }
    
    private func fetchData() {
        state = State.loading
        service.load { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let property):
                DispatchQueue.main.async {
                    self.state = .loaded(property)
                }
            case .failure(let error):
                state = .error(error)
            }
        }
    }
    
    func send(event: Event) {
        switch event {
        case .onAppear:
            fetchData()

        default:
            break
        }
    }
   
    // System states
    enum State {
        case loading
        case loaded(FeedProperty)
        case error(Error)
    }

    // UI events
    enum Event {
        case onAppear
        case onFailedToLoadData(Error)
    }
}
