//
//  PropertyListViewModel.swift
//  SampleListDetail
//
//  Created by AH on 2024-05-05.
//

import Foundation

final class PropertyListViewModel: ObservableObject {
    @Published private(set) var state = State.loadingList
    private let service: PropertyFeedLoader
    
    init(service: PropertyFeedLoader) {
        self.service = service
    }
    
    private func fetchData() {
        state = State.loadingList
        service.load { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let feed):
                DispatchQueue.main.async {
                    self.state = .loadedList(feed)
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
        }
    }
    
    /// System states
    enum State {
        case loadingList
        case loadedList([FeedProperty])
        case error(Error)
    }
    
    /// UI events
    enum Event {
        case onAppear
    }
}
