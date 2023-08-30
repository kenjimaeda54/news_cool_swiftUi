//
//  TopArticlesServices.swift
//  News Cools
//
//  Created by kenjimaeda on 30/08/23.
//

import Foundation

class TopArticlesWebService {
  var httpClient: HttpClient

  init(httpClient: HttpClient) {
    self.httpClient = httpClient
  }

  func fetchTopArticles(completion: @escaping (Result<TopArticlesModel, HttpError>) -> Void) async {
    let url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=e03da12b408445449464ceb16db4963a"

    guard let url = URL(string: url) else {
      return completion(.failure(.invalidURL))
    }

    do {
      let data: TopArticlesModel = try await httpClient.fetch(url: url)
      completion(.success(data))
    } catch {
      completion(.failure(.badResponse))
    }
  }
}
