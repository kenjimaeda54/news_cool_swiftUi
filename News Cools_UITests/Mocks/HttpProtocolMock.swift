//
//  HttpProtocolMock.swift
//  News Cools_UITests
//
//  Created by kenjimaeda on 01/09/23.
//

import Foundation

final class MockHttpClient: HttpClientProtocol, Mockable {
  func fetch<T: Codable>(url: URL) async throws -> T {
    return loadJson(filename: "TopArticles", type: T.self)
  }
}
