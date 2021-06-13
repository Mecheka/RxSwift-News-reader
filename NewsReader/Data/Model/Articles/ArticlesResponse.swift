//
//  ArticlesResponse.swift
//  NewsReader
//
//  Created by Suriya on 12/6/2564 BE.
//

import Foundation
import ObjectMapper

struct ArticlesResponse: Mappable {
    
    var status: String?
    var articles: Array<Articles>?
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        status <- map["status"]
        articles <- map["articles"]
    }
}
