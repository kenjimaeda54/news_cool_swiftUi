//
//  ContentView.swift
//  News Cools
//
//  Created by kenjimaeda on 28/08/23.
//

import SwiftUI

struct HomeScreen: View {
  @FocusState private var focusTextFieldSearch: Bool
  @State private var searchArticles = ""
  @ObservedObject private var storeHome = StoreHome(httpClient: HttpClientFactory.create())
  @State private var categorySelected = listCategoriesMock[0].id

  var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      ZStack(alignment: .leading) {
        Image(systemName: "magnifyingglass")
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: 20, height: 20)
          .offset(x: 10)
          .foregroundColor(ColorsApp.white)
        TextField(
          "",
          text: Binding(
            get: { searchArticles },
            set: { newValue, _ in
              if let _ = newValue.lastIndex(of: "\n") {
                searchArticles = ""
                focusTextFieldSearch = false
              } else {
                searchArticles = newValue
              }
            }
          ),
          prompt: Text("Search for aticles of interest to you")
            .foregroundColor(ColorsApp.white)
            .font(.custom(FontsApp.robotoLight, size: 18)),

          axis: .vertical
        )
        .onChange(of: searchArticles) { value in
          storeHome.handleSearchArticles(valueSearch: value, valueInput: searchArticles)
        }
        .padding(EdgeInsets(top: 7, leading: 35, bottom: 7, trailing: 15))
        .background(
          RoundedRectangle(cornerRadius: 5)
            .stroke(ColorsApp.black100.opacity(0.5), lineWidth: 1)
        )
        .submitLabel(.done)
        .focused($focusTextFieldSearch)
        .accessibilityIdentifier(TestsIdentifier.textFieldSearchNews)
      }
      .padding(EdgeInsets(top: 15, leading: 13, bottom: 15, trailing: 13))

      Text("Explore")
        .font(.custom(FontsApp.robotoRegular, size: 18))
        .foregroundColor(ColorsApp.white)
        .padding(EdgeInsets(top: 0, leading: 13, bottom: 0, trailing: 13))

      ScrollView(.horizontal, showsIndicators: false) {
        LazyHGrid(rows: gridItemExplore) {
          ForEach(listCategoriesMock) { categorie in
            RowToCategories(category: categorie, categoryIdSelected: categorySelected)
              .accessibilityIdentifier("\(TestsIdentifier.rowCategories)_\(categorie.id)")
              .gesture(
                TapGesture()
                  .onEnded { _ in
                    storeHome.handleTapCategory(categorie.title)
                    categorySelected = categorie.id
                  }
              )
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

      switch storeHome.loading {
      case .success:
        List(storeHome.articles) { topArticles in
          if topArticles.articles.title != nil && topArticles.articles.title != "[Removed]" && topArticles.articles
            .urlToImage != nil
          {
            RowToArticles(articles: topArticles.articles)
              .listRowInsets(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
              .listRowSeparator(.hidden)
              // hacker pra deixar o background transparente das rows
              .listRowBackground(ColorsApp.primary.opacity(0.0))
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
    .onAppear {
      storeHome.fetchArticles()
    }
    // .task {
    // await storeHome.fetchArticles()
    // }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    HomeScreen()
  }
}
