//
//  RowToCategories.swift
//  News Cools
//
//  Created by kenjimaeda on 30/08/23.
//

import SwiftUI

struct RowToCategories: View {
  let category: ExploreModel
  let categoryIdSelected: String

  var body: some View {
    ZStack {
      AsyncImage(url: URL(string: category.urlImage), scale: 7) { phase in
        if let image = phase.image {
          image
            .resizable()
            .frame(width: 85, height: 85)
            .clipShape(Circle())
            .opacity(0.8)

        } else {
          PlaceHolderImageCategory()
        }
      }
      .accessibilityIdentifier(category.urlImage)
      Text(category.title)
        .font(.custom(FontsApp.robotoBold, size: 12))
        .foregroundColor(ColorsApp.whiteAnyApperance)
        .accessibilityIdentifier(category.title)
    }
    .opacity(category.id == categoryIdSelected ? 1 : 0.3)
  }
}

struct RowToCategories_Previews: PreviewProvider {
  static var previews: some View {
    RowToCategories(category: listCategoriesMock[0], categoryIdSelected: UUID().uuidString)
  }
}
