//
//  NewsClient .swift
//  News
//
//  Created by Jacksons MacBook on 28.03.2021.
//

import Foundation

class NewsClient {
    private let APIKey = "d9763f7b033445e38fc64501df4e05fe"
    static var word: String?
    
    func getLatestNewsUsing(handler: @escaping ([Post]) -> ()) {
        let urlString = "https://newsapi.org/v2/everything?q=\(NewsClient.word ?? "apple")&sortBy=publishedAt&apiKey=\(APIKey)"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error == nil, data != nil {
                do {
                    let newsResponse = try JSONDecoder().decode(NewsResponse.self, from: data!)
                    var allNewsResponses = [Post]()
                    
                    for response in newsResponse.articles! {
                        allNewsResponses.append(Post(source: response.source?.name!,
                                                     title: response.title,
                                                     author: response.author,
                                                     urlToImage: response.urlToImage,
                                                     description: response.description,
                                                     content: response.content!,
                                                     url: response.url))
                    }
                    handler(allNewsResponses)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }
}
