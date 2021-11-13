//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Emil Vaklinov on 04/11/2021.
//

import Foundation


public enum LoadFeedResult {
    case success([FeedItem])
    case failure(Error)
    
}

public protocol FeedLoader {
    
    func load(completion: @escaping (LoadFeedResult) -> Void)
}
