//
//  Mockable.swift
//  News Cools_UITests
//
//  Created by kenjimaeda on 30/08/23.
//

import Foundation

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
      fatalError("Failed to load JSON file")
    }

    do {
      let data = try Data(contentsOf: path)
      let decodeObject = try JSONDecoder().decode(T.self, from: data)
      return decodeObject
    } catch {
      print(error.localizedDescription)
      fatalError("Failed to decode json")
    }
  }
}
