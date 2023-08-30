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
