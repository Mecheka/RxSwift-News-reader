//
//  SourceResponse.swift
//  NewsReader
//
//  Created by Suriya on 11/6/2564 BE.
//

import Foundation
import ObjectMapper

struct SourceResponse: Mappable {
    
    var status: String?
    var sources: Array<Source>?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        status <- map["status"]
        sources <- map["sources"]
    }
}
