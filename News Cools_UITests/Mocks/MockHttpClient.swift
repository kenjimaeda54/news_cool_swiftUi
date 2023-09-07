//
//  HttpProtocolMock.swift
//  News Cools_UITests
//
//  Created by kenjimaeda on 01/09/23.
//

import Foundation

class MockHttpClient: HttpClientProtocol, Mockable {
  func fetchCategoryArticles(
    category: String,
    completion: @escaping (Result<[ArticlesIdentifiableModel], HttpError>) -> Void
  ) {
    let response = loadJson(filename: "CategoryArticles", type: TopArticlesModel.self)
    let articles = response.articles.map { ArticlesIdentifiableModel(id: UUID().uuidString, articles: $0) }
    completion(.success(articles))
  }

  func fetchAllArticles(completion: @escaping (Result<[ArticlesIdentifiableModel], HttpError>) -> Void) {
    let response = loadJson(filename: "TopArticles", type: TopArticlesModel.self)
    let articles = response.articles.map { ArticlesIdentifiableModel(id: UUID().uuidString, articles: $0) }
    completion(.success(articles))
  }

  func fetchSearchArticles(
    search: String,
    completion: @escaping (Result<[ArticlesIdentifiableModel], HttpError>) -> Void
  ) {
    let response = loadJson(filename: "FilterArticles", type: TopArticlesModel.self)
    let articles = response.articles.map { ArticlesIdentifiableModel(id: UUID().uuidString, articles: $0) }
    completion(.success(articles))
  }
}
