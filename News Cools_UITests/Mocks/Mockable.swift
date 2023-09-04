//
//  Mockable.swift
//  News Cools_UITests
//
//  Created by kenjimaeda on 01/09/23.
//

import Foundation

// cuidado a implementação do extesion Mockable precisa ser identico ao Mockable
// se não ira exigir a implementação desse protocolo onde ele for usado como HttProtocolMock
protocol Mockable: AnyObject {
  var bundle: Bundle { get }
  func loadJson<T: Decodable>(filename: String, type: T.Type) -> T
}

extension Mockable {
  var bundle: Bundle {
    return Bundle(for: type(of: self))
  }

  func loadJson<T: Decodable>(filename: String, type: T.Type) -> T {
    guard let path = bundle.url(forResource: filename, withExtension: "json") else {
      fatalError("Failed to load Json file")
    }

    do {
      let data = try Data(contentsOf: path)
      let decodeObject = try JSONDecoder().decode(T.self, from: data)
      return decodeObject
    } catch {
      fatalError("Failed decode json")
    }
  }
}
