//
//  TopArticlesServices.swift
//  News Cools
//
//  Created by kenjimaeda on 30/08/23.
//

import Foundation

// referencia

// https://github.com/codewithchris/YT-Vapor-iOS-App/blob/lesson-5/YT-Vapor-iOS-App/Utilities/HttpClient.swift

enum HttpError: Error {
  case badURL, badResponse, errorDecondinData, invalidURL, invalidRequest
}

class HttpClient: HttpClientProtocol {
  func fetch<T: Codable>(url: URL) async throws -> T {
    let (data, response) = try await URLSession.shared.data(from: url)

    guard (response as? HTTPURLResponse)?.statusCode == 200 else {
      throw HttpError.badResponse
    }

    do {
      let object = try JSONDecoder().decode(T.self, from: data)
      return object

    } catch {
      throw HttpError.errorDecondinData
    }
  }
}
