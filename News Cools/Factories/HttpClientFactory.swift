//
//  HTTPClientFactory.swift
//  News Cools
//
//  Created by kenjimaeda on 01/09/23.
//

import Foundation

//se começar dar uma falhas estranhas de symbol verifica o target menbership
//esse arquivo precisa estar em ambos, todos arquivos que são usados em outro target e nesse precisa
//estar no cheking no target membership
class HttpClientFactory {
  static func create() -> HttpClientProtocol {
    let environment = ProcessInfo.processInfo.environment["ENV"]

    return environment == "TEST" ? MockHttpClient() : HttpClient()
  }
}
