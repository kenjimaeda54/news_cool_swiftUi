//
//  PlaceHolders.swift
//  News Cools
//
//  Created by kenjimaeda on 30/08/23.
//

import SwiftUI

struct PlaceHolderImageCategory: View {
  var body: some View {
    VStack {}
      .frame(width: 85, height: 85)
      .background(
        Circle()
          .foregroundColor(ColorsApp.placeholderDark)
      )
      .redactShimmer(condition: true)
  }
}

struct PlaceHolderImageCategory_Previews: PreviewProvider {
  static var previews: some View {
    PlaceHolderImageCategory()
  }
}

struct PlaceHolderListArticles: View {
  var body: some View {
    List(topArticlesMock) { topArticles in
      RowToArticles(articles: topArticles.articles)
        .listRowInsets(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
        .listRowSeparator(.hidden)
        // hacker pra deixar o background transparente das rows
        .listRowBackground(ColorsApp.primary.opacity(0.0))
        .accessibilityIdentifier("\(TestsIdentifier.rowArticles)_\(topArticles.id)")
    }
    .redactShimmer(condition: true)
  }
}

struct PlaceHolderListArticles_Previews: PreviewProvider {
  static var previews: some View {
    PlaceHolderListArticles()
  }
}
