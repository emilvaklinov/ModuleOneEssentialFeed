//
//  EssentialFeedAPIEndToEndTests.swift
//  EssentialFeedAPIEndToEndTests
//
//  Created by Emil Vaklinov on 16/11/2021.
//

import XCTest
import EssentialFeed

class EssentialFeedAPIEndToEndTests: XCTestCase {
    
    func test_endToEndTestServerGetFeedResult_matchesFixedTestAccountData() {
           switch getFeedResult() {
           case let .success(items):
               XCTAssertEqual(items.count, 8, "Expected 8 items in the test account feed")
               
               items.enumerated().forEach { index, item in
                   XCTAssertEqual(item, expectedItem(at: index))
               }
               
           case let .failure(error):
               XCTFail("Expected to get success, got \(error) instead")
           
           case .none:
               XCTFail("Expected to get success, got nil instead")
           }
       }
       
       // MARK: - Helpers
       
       private func getFeedResult(file: StaticString = #filePath, line: UInt = #line) -> LoadFeedResult? {
           let testServerURL = URL(string: "https://essentialdeveloper.com/feed-case-study/test-api/feed")!
           let client = URLSessionHTTPClient()
           let loader = RemoteFeedLoader(url: testServerURL, client: client)
           trackForMemoryLeaks(client, file: file, line: line)
           trackForMemoryLeaks(loader, file: file, line: line)
           let exp = expectation(description: "Wait for load completion")
           
           var receivedResult: LoadFeedResult?
           loader.load { result in
               receivedResult = result
               exp.fulfill()
           }
           
           wait(for: [exp], timeout: 5.0)
           return receivedResult
       }
       
       private func expectedItem(at index: Int) -> FeedItem {
           return FeedItem(id: id(at: index), description: description(at: index), location: location(at: index), imageURL: imageURL(at: index))
       }
       
       private func id(at index: Int) -> UUID {
           return UUID(uuidString: [
               "73A7F70C-75DA-4C2E-B5A3-EED40DC53AA6",
               "73A7F70C-75DA-4C2E-B5A3-EED40DC53AA7"
           ][index])!
       }
       
       private func description(at index: Int) -> String? {
           return [
               "Description 1",
               nil
           ][index]
       }
       
       private func location(at index: Int) -> String? {
           return [
               "Location 1",
               "Location 2"
           ][index]
       }
       
       private func imageURL(at index: Int) -> URL {
           return URL(string: "https://url-(index+1).com")!
       }
   }
