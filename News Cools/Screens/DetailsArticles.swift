//
//  DetailsArticles.swift
//  News Cools
//
//  Created by kenjimaeda on 07/09/23.
//

import SwiftUI

struct DetailsArticles: View {
  @Environment(\.dismiss) var dismiss
  let urlString: String

  func handleBack() {
    dismiss()
  }

  var body: some View {
    NavigationStack {
      VStack {
        WebView(urlString: urlString)
      }
    }
    .toolbar {
      ToolbarItem(placement: .navigationBarLeading) {
        Button(action: handleBack) {
          Image(systemName: "chevron.left")
            .foregroundColor(
              ColorsApp.black100
            )
        }
        .accessibilityIdentifier(TestsIdentifier.backButtonDetailsScreen)
      }
    }
    .accessibilityIdentifier("DetailsScreen_\(urlString)")
  }
}

struct DetailsArticles_Previews: PreviewProvider {
  static var previews: some View {
    DetailsArticles(urlString: "https://google.com")
  }
}
