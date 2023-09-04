//
//  ContentView.swift
//  News Cools
//
//  Created by kenjimaeda on 28/08/23.
//

import SwiftUI

struct HomeScreen: View {
  @StateObject private var storeArticles = StoreTopArticle()

  var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      Text("Explore")
        .font(.custom(FontsApp.robotoRegular, size: 18))
        .foregroundColor(ColorsApp.white)
        .padding(EdgeInsets(top: 0, leading: 13, bottom: 0, trailing: 13))

      ScrollView(.horizontal, showsIndicators: false) {
        LazyHGrid(rows: gridItemExplore) {
          ForEach(listCategoriesMock) { categorie in
            RowToCategories(category: categorie)
              .accessibilityIdentifier("\(TestsIdentifier.rowCategories)_\(categorie.id)")
          }
        }
        .accessibilityIdentifier(TestsIdentifier.gridCategories)
      }
      .padding(EdgeInsets(top: 10, leading: 13, bottom: 10, trailing: 0))
      .frame(height: 130)

      Text("Hottest News")
        .font(.custom(FontsApp.robotoRegular, size: 18))
        .foregroundColor(ColorsApp.white)
        .padding(EdgeInsets(top: 10, leading: 13, bottom: 10, trailing: 13))

      switch storeArticles.loading {
      case .success:
        List(storeArticles.articles) { topArticles in
          if topArticles.articles.title != nil && topArticles.articles.title != "[Removed]" && topArticles.articles
            .urlToImage != nil
          {
            RowToArticles(articles: topArticles.articles)
              .listRowInsets(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
              .listRowSeparator(.hidden)
              // hacker pra deixar o background transparente das rows
              .listRowBackground(ColorsApp.primary.opacity(0.0))
              .accessibilityIdentifier("\(TestsIdentifier.rowArticles)_\(topArticles.id)")
          }
        }
        .listStyle(.inset)
        .scrollIndicators(.hidden)
        .padding(EdgeInsets(top: 10, leading: 13, bottom: 10, trailing: 13))
        .accessibilityIdentifier(TestsIdentifier.listArticles)

      case .loading:
        PlaceHolderListArticles()

      default:
        Text("error")
      }
    }

    .scrollBounceBehavior(.basedOnSize)
    .scrollContentBackground(.hidden)
    .background(ColorsApp.primary, ignoresSafeAreaEdges: .all)
    .task {
      await storeArticles.fetchTopArticles()
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    HomeScreen()
  }
}
