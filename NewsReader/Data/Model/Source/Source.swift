//
//  Source.swift
//  NewsReader
//
//  Created by Suriya on 10/6/2564 BE.
//

import Foundation
import ObjectMapper

struct Source: Mappable {
    
    var id: String?
    var name: String?
    var description: String?
    var url: URL?
    var category: String?
    var language: String?
    var country: String?
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        description <- map["description"]
        url <- (map["url"], URLTransform())
        category <- map["category"]
        language <- map["language"]
        country <- map["country"]
    }
}
