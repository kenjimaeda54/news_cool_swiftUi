//
//  HttpClientProtocol.swift
//  News Cools
//
//  Created by kenjimaeda on 01/09/23.
//

import Foundation

enum HttpError: Error {
  case badURL, badResponse, errorEncodingData, noData, invalidURL, invalidRequest
}

protocol HttpClientProtocol {
  func fetchAllArticles(completion: @escaping (Result<[ArticlesIdentifiableModel], HttpError>) -> Void)
  func fetchSearchArticles(
    search: String,
    completion: @escaping (Result<[ArticlesIdentifiableModel], HttpError>) -> Void
  )
  func fetchCategoryArticles(
    category: String,
    completion: @escaping (Result<[ArticlesIdentifiableModel], HttpError>) -> Void
  )
}
