//
//  Constants.swift
//  News Cools
//
//  Created by kenjimaeda on 29/08/23.
//

import Foundation
import SwiftUI

// MARK: - Layout

let rowSpacing: CGFloat = 13
var gridItemExplore: [GridItem] {
  return Array(repeating: GridItem(.flexible(), spacing: rowSpacing), count: 1)
}

enum TestsIdentifier {
  static var rowCategories = "gridCategories"
  static var rowArticles = "rowArticles"
  static var listArticles = "listArticles"
  static var gridCategories = "gridCategories"
  static var textFieldSearchNews = "textFieldSearchNews"
  static var urlWebViewDetailsScreen =
    "https://www.cnn.com/2023/08/29/politics/francis-suarez-ends-president-campaign-republican/index.html"
  static var backButtonDetailsScreen = "backButtonDetailsScreen"
}
