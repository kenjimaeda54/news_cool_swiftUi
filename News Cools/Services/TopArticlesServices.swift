//
//  TopArticlesServices.swift
//  News Cools
//
//  Created by kenjimaeda on 01/09/23.
//

import Foundation

class TopArticlesServices: ObservableObject {
  @Published var articles: [ArticlesIdentifiableModel] = []
  @Published var loading = LoadingState.loading
  var client: HttpClientProtocol

  init(client: HttpClientProtocol) {
    self.client = HttpClientFactory.create()
  }

  func fetchAllArticles() async {
    do {
      let response: TopArticlesModel = try await client
        .fetch(urlString: "https://newsapi.org/v2/top-headlines?country=us&apiKey=e03da12b408445449464ceb16db4963a")
      DispatchQueue.main.async {
        self.articles = response.articles.map { ArticlesIdentifiableModel(id: UUID().uuidString, articles: $0) }
        self.loading = LoadingState.success
      }
    } catch {
      print(error.localizedDescription)
      loading = LoadingState.failure
    }
  }

  func fetchSearchArticles(search: String) async {
    do {
      let response: TopArticlesModel = try await client
        .fetch(
          urlString: "https://newsapi.org/v2/everything?q=\(search)&from=\(returnMonthLast())&sortBy=popularity&apiKey=e03da12b408445449464ceb16db4963a"
        )
      DispatchQueue.main.async {
        self.articles = response.articles.map { ArticlesIdentifiableModel(id: UUID().uuidString, articles: $0) }
        self.loading = LoadingState.success
      }
    } catch {
      print(error.localizedDescription)
      loading = LoadingState.failure
    }
  }
}
