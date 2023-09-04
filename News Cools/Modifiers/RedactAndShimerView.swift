//
//  RedactAndShimerView.swift
//  News Cools
//
//  Created by kenjimaeda on 30/08/23.
//

import Foundation
import SwiftUI

public struct RedactAndShimmerView: ViewModifier {
  private let condition: Bool

  init(condition: Bool) {
    self.condition = condition
  }

  public func body(content: Content) -> some View {
    if condition {
      content
        .redacted(reason: .placeholder)
        .shimmering()
    } else {
      content
    }
  }
}

extension View {
  func redactShimmer(condition: Bool) -> some View {
    modifier(RedactAndShimmerView(condition: condition))
  }
}
