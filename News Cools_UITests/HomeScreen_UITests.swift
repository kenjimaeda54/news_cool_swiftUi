//
//  News_Cools_UITests.swift
//  News Cools_UITests
//
//  Created by kenjimaeda on 30/08/23.
//

import ViewInspector
import XCTest

final class News_Cools_UITests: XCTestCase {
  let app = XCUIApplication()

  override func setUpWithError() throws {
    continueAfterFailure = false
    app.launch()
  }

  override func tearDownWithError() throws {}

  func test_HomeScreen_text_shouldHaveText() throws {
    let text = app.staticTexts["Explore"].firstMatch
    XCTAssertTrue(text.exists)
  }
}
