//
//  NewsResponse.swift
//  News
//
//  Created by Jacksons MacBook on 28.03.2021.
//

import Foundation

struct NewsResponse: Codable {
    var articles: [ArticlesModel]?
}

struct ArticlesModel: Codable {
    var source: SourceResponse?
    var author: String?
    var title: String?
    var description: String?
    var urlToImage: String?
    var url: String?
    var content: String?
}

struct SourceResponse: Codable {
    var name: String?
}
