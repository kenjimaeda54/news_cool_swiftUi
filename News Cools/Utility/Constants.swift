//
//  Constants.swift
//  News Cools
//
//  Created by kenjimaeda on 29/08/23.
//

import Foundation
import SwiftUI

// MARK: - Layout

let rowSpacing: CGFloat = 13
var gridItemExplore: [GridItem] {
  return Array(repeating: GridItem(.flexible(), spacing: rowSpacing), count: 1)
}
