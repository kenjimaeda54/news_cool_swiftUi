//
//  StoreTopArticles.swift
//  News Cools
//
//  Created by kenjimaeda on 30/08/23.
//

import Foundation

// refenciia pra criar o HttpClientFactory
// https://github.com/azamsharp/AzamSharp-Weekly/tree/master/IntroductionToMocking

class StoreTopArticle: ObservableObject {
  var articles: [ArticlesIdentifiableModel] = []
  @Published var loading = LoadingState.loading
  // quando rodar o teste ele ira fazer a request nosso json mocado e ja vai refletir na view
  // sem precisar fazer nenhuma requisição no arquivo de test
  var topArticlesServices = TopArticlesServices(client: HttpClientFactory.create())

  func fetchTopArticles() async {
    await topArticlesServices.fetchAllArticles { result in
      switch result {
      case let .success(topArticles):

        DispatchQueue.main.async {
          self.loading = LoadingState.success
          self.articles = topArticles.articles.map { ArticlesIdentifiableModel(id: UUID().uuidString, articles: $0) }
        }

      case let .failure(error):
        print(error)

        DispatchQueue.main.async {
          self.loading = LoadingState.failure
        }
      }
    }
  }
}
