//
//  TopArticlesModel.swift
//  News Cools
//
//  Created by kenjimaeda on 28/08/23.
//

import Foundation

struct TopArticlesModel: Codable {
  let status: String
  let totalResults: Int
  let articles: [Articles]
}

// forma de lidar com estruras de API que não possui id
// ja inicializo um id pra ele
struct Articles: Codable, Identifiable {
  var id = UUID()
  let source: Source
  let author: String
  let title: String
  let description: String
  let url: String
  let urlToImage: String?
  let publishedAt: String
  let content: String
}

struct Source: Codable {
  let id: String
  let name: String
}
