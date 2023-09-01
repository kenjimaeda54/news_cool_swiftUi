//
//  HttpClientProtocol.swift
//  News Cools
//
//  Created by kenjimaeda on 01/09/23.
//

import Foundation

protocol HttpClientProtocol {
  func fetch<T: Codable>(url: URL) async throws -> T
}
