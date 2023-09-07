//
//  StoreHome.swift
//  News Cools
//
//  Created by kenjimaeda on 05/09/23.
//

import Foundation

// segredo e criar um protoloco que de match com todas as requisições
// tanto as que serão reais quanto as mocadas

// precisa implementar a logica de negocio da home aqui tambem
class StoreHome: ObservableObject {
  @Published var articles: [ArticlesIdentifiableModel] = []
  @Published var loading = LoadingState.loading
  private let httpClient: HttpClientProtocol

  init(httpClient: HttpClientProtocol = HttpClientFactory.create()) {
    self.httpClient = httpClient
  }

  func fetchArticles() {
    httpClient.fetchAllArticles { result in

      switch result {
      case let .success(articles):

        DispatchQueue.main.async {
          self.loading = LoadingState.success
          self.articles = articles
        }

      case let .failure(error):
        DispatchQueue.main.async {
          self.loading = LoadingState.failure
        }
      }
    }
  }

  func fetchSearchArticles(_ word: String) {
    httpClient.fetchSearchArticles(search: word) { result in

      switch result {
      case let .success(articles):

        DispatchQueue.main.async {
          self.loading = LoadingState.success
          self.articles = articles
        }

      case let .failure(error):
        DispatchQueue.main.async {
          self.loading = LoadingState.failure
        }
      }
    }
  }

  func fetchArticlesByCategory(_ category: String) {
    httpClient.fetchCategoryArticles(category: category) { result in

      switch result {
      case let .success(articles):

        DispatchQueue.main.async {
          self.loading = LoadingState.success
          self.articles = articles
        }

      case let .failure(error):
        DispatchQueue.main.async {
          self.loading = LoadingState.failure
        }
      }
    }
  }

  // com essa função consigo testar o fetchSearchArticles
  func handleSearchArticles(valueSearch newValue: String, valueInput: String) {
    if valueInput.count > 3 && valueInput.count % 4 == 0 {
      fetchSearchArticles(newValue)
    }
  }

  func handleTapCategory(_ category: String) {
    fetchArticlesByCategory(category)
  }
}
