//
//  HttpClientProtocol.swift
//  News Cools
//
//  Created by kenjimaeda on 01/09/23.
//

import Foundation

protocol HttpClientProtocol {
  func fetch<T: Codable>(urlString: String) async throws -> T
}
