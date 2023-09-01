//
//  TopArticlesServices.swift
//  News Cools
//
//  Created by kenjimaeda on 01/09/23.
//

import Foundation

class TopArticlesServices {
  var client: HttpClientProtocol

  init(client: HttpClientProtocol) {
    self.client = HttpClientFactory.create()
  }

  func fetchAllArticles(completion: @escaping (Result<TopArticlesModel, HttpError>) -> Void) async {
    guard let url =
      URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=e03da12b408445449464ceb16db4963a")
    else {
      return completion(.failure(.badURL))
    }

    do {
      let response: TopArticlesModel = try await client.fetch(url: url)
      completion(.success(response))
    } catch {
      print(error.localizedDescription)
      completion(.failure(.invalidRequest))
    }
  }
}
