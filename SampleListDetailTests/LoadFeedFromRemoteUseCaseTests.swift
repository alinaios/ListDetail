//
//  FeedPropertyMapperTests.swift
//  SampleListDetailTests
//
//  Created by AH on 2024-05-06.
//

import XCTest
@testable import SampleListDetail

final class LoadFeedFromRemoteUseCaseTests: XCTestCase {

    func test_init_doesNotRequestDataFromURL() {
        let (_, client) = makeSUT()

        XCTAssertTrue(client.requestedURLs.isEmpty)
    }
    
    func test_load_deliversConnectivityErrorOnClientError() {
        let (sut, client) = makeSUT()

        expect(sut, toCompleteWith: .failure(.connectivity), when: {
            let clientError = NSError(domain: "Test", code: 0)
            client.complete(with: clientError)
        })
    }
    
    func test_load_deliversInvalidDataErrorOnNon200HTTPResponse() {
        let (sut, client) = makeSUT()

        let samples = [199, 201, 300, 400, 500]

        samples.enumerated().forEach { index, code in
            expect(sut, toCompleteWith: .failure(.invalidData), when: {
                let json = makeItemsJSON([])
                client.complete(withStatusCode: code, data: json, at: index)
            })
        }
    }
    
    func test_load_deliversSuccessWithItemsOn200HTTPResponseWithJSONItems() {
        let (sut, client) = makeSUT()

        let item1 = makeItem(id: "111", area: "area", imageURL: "http://a-url.com")

        let item2 = makeItem( id: "222", area: "area222", imageURL: "http://a-url.com")

        let items = [item1.model, item2.model]

        expect(sut, toCompleteWith: .success(items), when: {
            let json = makeItemsJSON([item1.json, item2.json])
            client.complete(withStatusCode: 200, data: json)
        })
    }
    
    func test_load_doesNotDeliverResultAfterSUTInstanceHasBeenDeallocated() {
        let url = URL(string: "http://any-url.com")!
        let client = HTTPClientSpy()
        var sut: RemoteFeedLoader? = RemoteFeedLoader(url: url, client: client)

        var capturedFeedResults = [RemoteFeedLoader.FeedResult]()
        sut?.load { capturedFeedResults.append($0) }

        var capturedDetailResults = [RemoteFeedLoader.DetailResult]()
        sut?.load { capturedDetailResults.append($0) }

        sut = nil
        client.complete(withStatusCode: 200, data: makeItemsJSON([]))

        XCTAssertTrue(capturedFeedResults.isEmpty)
        XCTAssertTrue(capturedDetailResults.isEmpty)
    }
    
    // MARK: - Helpers
    ///   SUT -  system under test
    ///   In the makeSUT function, file: StaticString = #filePath is a parameter with a default value. This parameter is designed to capture the file path where makeSUT is called. If no value is provided explicitly when calling makeSUT, the compiler automatically substitutes the file path where makeSUT is defined.
    private func makeSUT(url: URL = URL(string: "https://a-url.com")!, file: StaticString = #filePath, line: UInt = #line) -> (sut: RemoteFeedLoader, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = RemoteFeedLoader(url: url, client: client)
        return (sut, client)
    }
    
    private func makeItemsJSON(_ items: [[String: Any]]) -> Data {
        let json = ["items": items]
        return try! JSONSerialization.data(withJSONObject: json)
    }
    
    private func makeItem(id: String, area: String, imageURL: String) -> (model: FeedProperty, json: [String: Any]) {
        let item = FeedProperty(type: .property, id: id, area: area, image: imageURL)

        let json = [
            "type": "Property",
            "id": id,
            "area": area,
            "image": imageURL
        ].compactMapValues { $0 }

        return (item, json)
    }
}
extension LoadFeedFromRemoteUseCaseTests {
    func expect(_ sut: RemoteFeedLoader, toCompleteWith expectedResult: Result<[FeedProperty], RemoteFeedLoader.Error>, when action: () -> Void, file: StaticString = #filePath, line: UInt = #line) {
        let exp = expectation(description: "Wait for load completion")

        sut.load { receivedResult in
            switch (receivedResult, expectedResult) {
            case let (.success(receivedItems), .success(expectedItems)):
                XCTAssertEqual(receivedItems, expectedItems, file: file, line: line)

            case let (.failure(receivedError as RemoteFeedLoader.Error), .failure(expectedError)):
                XCTAssertEqual(receivedError, expectedError, file: file, line: line)

            default:
                XCTFail("Expected result \(expectedResult) got \(receivedResult) instead", file: file, line: line)
            }

            exp.fulfill()
        }

        action()

        waitForExpectations(timeout: 0.1)
    }
}
