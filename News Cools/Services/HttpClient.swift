//
//  TopArticlesServices.swift
//  News Cools
//
//  Created by kenjimaeda on 01/09/23.
//

import Foundation

class HttpClient: HttpClientProtocol {
  func fetchCategoryArticles(
    category: String,
    completion: @escaping (Result<[ArticlesIdentifiableModel], HttpError>) -> Void
  ) {
    guard let url =
      URL(
        string: "https://newsapi.org/v2/top-headlines?country=us&category=\(category)&apiKey=e03da12b408445449464ceb16db4963a"
      )
    else {
      return completion(.failure(.badURL))
    }

    URLSession.shared.dataTask(with: url) { data, _, error in

      guard let data = data, error == nil else {
        return completion(.failure(.noData))
      }

      do {
        let response = try JSONDecoder().decode(TopArticlesModel.self, from: data)
        let articlesIdentifible = response.articles
          .map { ArticlesIdentifiableModel(id: UUID().uuidString, articles: $0) }
        completion(.success(articlesIdentifible))
      } catch {
        completion(.failure(.errorEncodingData))
      }
    }.resume()
  }

  func fetchAllArticles(completion: @escaping (Result<[ArticlesIdentifiableModel], HttpError>) -> Void) {
    guard let url =
      URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=e03da12b408445449464ceb16db4963a")
    else {
      return completion(.failure(.badURL))
    }

    URLSession.shared.dataTask(with: url) { data, _, error in

      guard let data = data, error == nil else {
        return completion(.failure(.noData))
      }

      do {
        let response = try JSONDecoder().decode(TopArticlesModel.self, from: data)
        let articlesIdentifible = response.articles
          .map { ArticlesIdentifiableModel(id: UUID().uuidString, articles: $0) }
        completion(.success(articlesIdentifible))
      } catch {
        completion(.failure(.errorEncodingData))
      }
    }.resume()
  }

  func fetchSearchArticles(
    search: String,
    completion: @escaping (Result<[ArticlesIdentifiableModel], HttpError>) -> Void
  ) {
    guard let url =
      URL(
        string: "https://newsapi.org/v2/everything?q=\(search)&from=\(returnMonthLast())&sortBy=popularity&apiKey=e03da12b408445449464ceb16db4963a"
      )
    else {
      return completion(.failure(.badURL))
    }

    URLSession.shared.dataTask(with: url) { data, _, error in

      guard let data = data, error == nil else {
        return completion(.failure(.noData))
      }

      do {
        let response = try JSONDecoder().decode(TopArticlesModel.self, from: data)
        let articlesIdentifible = response.articles
          .map { ArticlesIdentifiableModel(id: UUID().uuidString, articles: $0) }
        completion(.success(articlesIdentifible))
      } catch {
        completion(.failure(.errorEncodingData))
      }
    }.resume()
  }
}
