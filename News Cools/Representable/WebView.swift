//
//  WebView.swift
//  News Cools
//
//  Created by kenjimaeda on 07/09/23.
//

import Foundation
import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
  let urlString: String

  func makeUIView(context: Context) -> WKWebView {
    return WKWebView()
  }

  func updateUIView(_ webView: WKWebView, context: Context) {
    if let url = URL(string: urlString) {
      let request = URLRequest(url: url)
      webView.load(request)
    }
  }
}
