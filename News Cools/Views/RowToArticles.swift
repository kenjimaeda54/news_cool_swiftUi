//
//  RowToArticles.swift
//  News Cools
//
//  Created by kenjimaeda on 29/08/23.
//

import SwiftUI

struct RowToArticles: View {
  let articles: Articles
  var relativeDateString: String {
    let formaterStringToDate = ISO8601DateFormatter()
    let date = formaterStringToDate.date(from: articles.publishedAt ?? "")
    let formatter = RelativeDateTimeFormatter()
    formatter.unitsStyle = .full
    let relativeDate = formatter.localizedString(for: date ?? Date(), relativeTo: Date())
    return relativeDate
  }

  var body: some View {
    HStack {
      VStack {
        HStack {
          Text(articles.source?.name ?? "")
            .font(.custom(FontsApp.robotoLight, size: 11))
            .foregroundColor(ColorsApp.white)
          Spacer()
          Text(relativeDateString)
            .font(.custom(FontsApp.robotoLight, size: 11))
            .foregroundColor(ColorsApp.white)
        }

        Text(articles.title ?? "")
          .lineLimit(2)
          .fontWithLineHeight(font: UIFont(name: FontsApp.robotoRegular, size: 15)!, lineHeight: 23)
          .foregroundColor(ColorsApp.white)
      }
      .padding(EdgeInsets(top: 3, leading: 10, bottom: 3, trailing: 10))
      AsyncImage(
        url: URL(
          string: articles
            .urlToImage ?? "https://upload.wikimedia.org/wikipedia/commons/d/d1/Image_not_available.png"
        ),
        scale: 20
      ) { phase in
        if let image = phase.image {
          image
            .resizable()
            .cornerRadius(5)
            .frame(width: 130)
            .aspectRatio(contentMode: .fill)

        } else {
          Image("not_found")
            .resizable()
            .scaledToFit()
            .frame(width: 100)
        }
      }
    }
    .frame(height: 100)
    .background(
      RoundedRectangle(cornerRadius: 5)
        .foregroundColor(ColorsApp.secondary)
    )
  }
}

struct RowToArticles_Previews: PreviewProvider {
  static var previews: some View {
    RowToArticles(articles: topArticlesMock.articles[1])
      .previewLayout(.sizeThatFits)
  }
}
