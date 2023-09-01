//
//  News_Cools_UITests.swift
//  News Cools_UITests
//
//  Created by kenjimaeda on 30/08/23.
//

import Combine
@testable import News_Cools
import XCTest

final class News_Cools_UITests: XCTestCase {
  var cancellables = Set<AnyCancellable>()

  private var app: XCUIApplication!

  override func setUpWithError() throws {
    continueAfterFailure = false
    app = XCUIApplication()
    app.launchEnvironment = ["ENV": "TEST"]
    app.launch()
  }

  override func tearDownWithError() throws {
    app = nil
    cancellables = []
  }

  func testReturnMockWebService() async {
    // esse texto e o que esta mocado no arquivo de json
		//sera inserido automatico pelo HttpClientFactory
    let text = app.staticTexts["Francis Suarez ends campaign for Republican presidential nomination - CNN"].firstMatch
    XCTAssertTrue(text.exists)
  }
}
