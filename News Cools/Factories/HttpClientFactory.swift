//
//  HttpFactory.swift
//  News Cools
//
//  Created by kenjimaeda on 06/09/23.
//

import Foundation

class HttpClientFactory {
  static func create() -> HttpClientProtocol {
    let arguments = ProcessInfo.processInfo.environment["ENV"]

    return arguments == "TEST" ? MockHttpClient() : HttpClient()
  }
}
