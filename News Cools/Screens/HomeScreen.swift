//
//  ContentView.swift
//  News Cools
//
//  Created by kenjimaeda on 28/08/23.
//

import SwiftUI

struct HomeScreen: View {
  var body: some View {
    VStack(alignment: .leading) {
      Text("Hottest News")
        .font(.custom(FontsApp.robotoRegular, size: 18))
        .foregroundColor(ColorsApp.white)

      List(topArticlesMock.articles) { articles in
        RowToArticles(articles: articles)
          .listRowInsets(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
          .listRowSeparator(.hidden)
          // hacker pra deixar o background transparente das rows
          .listRowBackground(ColorsApp.primary.opacity(0.0))
      }
      .listStyle(.inset)
    }
    .padding(EdgeInsets(top: 10, leading: 13, bottom: 10, trailing: 13))
    .scrollBounceBehavior(.basedOnSize)
    .scrollContentBackground(.hidden)
    .background(ColorsApp.primary, ignoresSafeAreaEdges: .all)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    HomeScreen()
  }
}
