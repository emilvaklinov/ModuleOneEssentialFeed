
//  XCTestCase+MemoryLeakTracking.swift
//  EssentialFeedTests
//
//  Created by Emil Vaklinov on 16/11/2021.
//

import XCTest

extension XCTestCase {
    
    func trackForMemoryLeaks(_ instance: AnyObject, file: StaticString = #filePath, line: UInt = #line) {
        // to test retain cycle
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Instance should be deallocated. Potential memory leak.", file: file, line: line)
        }
    }
}
