//
//  DetailsScreen_UITests.swift
//  News Cools_UITests
//
//  Created by kenjimaeda on 07/09/23.
//

import Foundation
import XCTest

final class DetailsScreen_UITests: XCTestCase {
  var app: XCUIApplication!

  override func setUpWithError() throws {
    continueAfterFailure = false

    app = XCUIApplication()
    app.launchEnvironment = ["ENV": "TEST"]
    app.launch()
  }

  override func tearDownWithError() throws {
    app = nil
  }

  func testNavigationAndLoadCorrectUrlWebViewDetailsScreen() {
    navigateDetailsScreen()

    let predicateDetailsScreen =
      NSPredicate(format: "identifier == 'DetailsScreen_\(TestsIdentifier.urlWebViewDetailsScreen)'")
    let view = app.descendants(matching: .any).matching(predicateDetailsScreen).firstMatch
    let exists = view.waitForExistence(timeout: 5)
    XCTAssertTrue(exists)
  }

  func testBackDetailsScreen() {
    navigateDetailsScreen()

    let predicate = NSPredicate(format: "identifier == '\(TestsIdentifier.backButtonDetailsScreen)'")
    let button = app.descendants(matching: .any).matching(predicate).firstMatch
    let buttonExists = button.waitForExistence(timeout: 5)
    XCTAssertTrue(buttonExists)
    button.tap()

    let predicateArticle = NSPredicate(format: "identifier == '\(TestsIdentifier.listArticles)'")
    let list = app.descendants(matching: .any).matching(predicateArticle).firstMatch
    let listExists = list.waitForExistence(timeout: 5)
    XCTAssertTrue(listExists)
  }
}

extension DetailsScreen_UITests {
  func navigateDetailsScreen() {
    let predicateArticle = NSPredicate(format: "identifier == '\(TestsIdentifier.listArticles)'")
    let list = app.descendants(matching: .any).matching(predicateArticle).firstMatch
    let singleRow = list.staticTexts["Francis Suarez ends campaign for Republican presidential nomination - CNN"]
      .firstMatch

    singleRow.tap()
  }
}
