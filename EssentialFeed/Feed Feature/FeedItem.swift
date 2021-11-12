//
//  FeedItem.swift
//  EssentialFeed
//
//  Created by Emil Vaklinov on 04/11/2021.
//

import Foundation


public struct FeedItem: Equatable {
    let id: UUID
    let description: String?
    let location: String?
    let imageURL: URL
}
