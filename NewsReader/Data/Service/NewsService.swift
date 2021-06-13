//
//  NewsService.swift
//  NewsReader
//
//  Created by Suriya on 10/6/2564 BE.
//

import Foundation
import Moya

enum NewsService {
    case getSource
    case getArticles(_ sourceName: String)
}

let apiKey: String = "f57c33db94e34f01ad0211978e4a7a00"

extension NewsService: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://newsapi.org/v2/")!
    }
    
    var path: String {
        switch self {
        case .getSource:
            return "sources"
        case .getArticles:
            return "top-headlines"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getSource:
            return .get
        case .getArticles:
            return .get
        }
    }
    
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    var task: Task {
        switch self {
        case .getSource:
            return .requestParameters(parameters: ["apiKey": apiKey], encoding: URLEncoding.default)
        case .getArticles(let source):
            return .requestParameters(parameters: ["sources": source, "apiKey": apiKey], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}
