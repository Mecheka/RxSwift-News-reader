//
//  Articles.swift
//  NewsReader
//
//  Created by Suriya on 12/6/2564 BE.
//

import Foundation
import ObjectMapper

struct Articles: Mappable {
    
    var source: Source?
    var author: String?
    var title: String?
    var description: String?
    var url: URL?
    var urlToImage: URL?
    var publishedAt: Date?
    var content: String?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        source <- map["source"]
        author <- map["author"]
        title <- map["title"]
        description <- map["description"]
        url <- (map["url"], URLTransform())
        urlToImage <- (map["urlToImage"], URLTransform())
        publishedAt <- (map["publishedAt"], DateTransform())
        content <- map["content"]
    }
}
