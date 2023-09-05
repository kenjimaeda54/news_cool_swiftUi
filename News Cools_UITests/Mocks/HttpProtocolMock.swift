//
//  HttpProtocolMock.swift
//  News Cools_UITests
//
//  Created by kenjimaeda on 01/09/23.
//

import Foundation

final class MockHttpClient: HttpClientProtocol, Mockable, ObservableObject {
  @Published var fileName = "TopArticles"

  func fetch<T>(urlString: String) async throws -> T where T: Decodable, T: Encodable {
    return loadJson(filename: fileName, type: T.self)
  }
}
