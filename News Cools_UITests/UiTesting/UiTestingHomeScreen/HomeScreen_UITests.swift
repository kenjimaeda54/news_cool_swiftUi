//
//  News_Cools_UITests.swift
//  News Cools_UITests
//
//  Created by kenjimaeda on 30/08/23.
//

@testable import News_Cools
import SnapshotTesting
import SwiftUI
import XCTest

// referencia
// https://github.com/tunds/SwiftUIiOSTakeHomeTest/blob/main/iOSTakeHomeProject/iOSTakeHomeProjectUITests/Create/CreateScreenUITests.swift

// quando adioncar uma lib para test como o spashot ele precisa estar apenas no target de tests e não no principal

final class News_Cools_UITests: XCTestCase {
  private var app: XCUIApplication!

  override func setUpWithError() throws {
    continueAfterFailure = false
    app = XCUIApplication()
    app.launchEnvironment = ["ENV": "TEST"]
    app.launch()
  }

  override func tearDownWithError() throws {
    app = nil
  }

  // referencia https://github.com/tunds/SwiftUIiOSTakeHomeTest/blob/main/iOSTakeHomeProject/iOSTakeHomeProjectUITests/People/PeopleScreenUITests.swift
  func testListArticles() {
    let predicateArticle = NSPredicate(format: "identifier == '\(TestsIdentifier.listArticles)'")
    let list = app.descendants(matching: .any).matching(predicateArticle).firstMatch
    let exists = list.waitForExistence(timeout: 5)
    XCTAssertTrue(exists)

    let predicateRow = NSPredicate(format: "identifier CONTAINS '\(TestsIdentifier.rowArticles)_'")
    // peguei imagem p/Users/kenjimaeda/Documents/projects_IOS/News Cools/News
    // Cools_UITests/UiTesting/UiTestingHomeScreen/HomeScreen_UITests.swiftorque apenas possui uma imagem no
    // predicateRow
    let rows = list.images.containing(predicateRow)
    XCTAssertEqual(rows.count, 2)
  }

  func testGridCategories() {
    let predicateGrid = NSPredicate(format: "identifier == '\(TestsIdentifier.gridCategories)'")
    let grid = app.descendants(matching: .any).matching(predicateGrid).firstMatch
    let exists = grid.waitForExistence(timeout: 5)
    XCTAssert(exists)

    let predicateRow = NSPredicate(format: "identifier CONTAINS '\(TestsIdentifier.rowCategories)_'")
    let rows = grid.staticTexts.containing(predicateRow)
    XCTAssertEqual(rows.count, listCategoriesMock.count)
  }

  func testValueTextFieldWhenTap() {
    let predicateTextField = NSPredicate(format: "identifier == '\(TestsIdentifier.textFieldSearchNews)'")
    let textField = app.descendants(matching: .any).matching(predicateTextField).firstMatch
    textField.tap()
    textField.typeText("Apple")

    XCTAssertEqual(textField.value as? String, "Apple")
  }

  // MARK: - Teste snashopt

  // referencia test com snapshot
  // https://www.kodeco.com/24426963-snapshot-testing-tutorial-for-swiftui-getting-started

  func testSnapshotRowArticles() {
    let rowView = RowToArticles(articles: Articles(
      source: Source(id: "cnn", name: "CNN"),
      author: "Kit Maher, Melissa Holzberg DePalo",
      title: "Francis Suarez ends campaign for Republican presidential nomination - CNN",
      description: "Miami Mayor Francis Suarez announced Tuesday that he is ending his campaign for the 2024 Republican presidential nomination.",
      url: "https://www.cnn.com/2023/08/29/politics/francis-suarez-ends-president-campaign-republican/index.html",
      urlToImage: "https://media.cnn.com/api/v1/images/stellar/prod/230822133803-01-francis-suarez-072823.jpg?c=16x9&q=w_800,c_fill",
      publishedAt: "2023-08-29T17:56:00Z",
      content: "Miami Mayor Francis Suarez announced Tuesday that he is ending his campaign for the 2024 Republican presidential nomination.\r\nWhile I have decided to suspend my campaign for President, my commitment …"))
    let view: UIView = UIHostingController(rootView: rowView).view
    assertSnapshot(of: view, as: .image)
  }

  func testSnapshotRowCategories() {
    let rowView = RowToCategories(category: listCategoriesMock[0])
    let view: UIView = UIHostingController(rootView: rowView).view
    assertSnapshot(of: view, as: .image)
  }
}
