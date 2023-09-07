//
//  News_Cools_UITests.swift
//  News Cools_UITests
//
//  Created by kenjimaeda on 30/08/23.
//

import Combine
@testable import News_Cools
import SnapshotTesting
import SwiftUI
import XCTest

// referencia
// https://github.com/tunds/SwiftUIiOSTakeHomeTest/blob/main/iOSTakeHomeProject/iOSTakeHomeProjectUITests/Create/CreateScreenUITests.swift

// quando adioncar uma lib para test como o spashot ele precisa estar apenas no target de tests e não no principal


// a partir da nova versão o xcode usa planos de tests que uma maneira mais simples de controlar configurações complexas de testss
// apos qualquer alteração precisa salvar o arquivo
// referencia https://emptytheory.com/2023/02/26/test-plans-are-now-default-for-new-projects-with-xcode-14-3/
// na ultima solçução do stack flow
// https://stackoverflow.com/questions/76192332/how-can-i-enable-code-coverage-in-xcode-14-3-it-appears-different-from-other-v

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

  // referencia uitest
  func testListArticles() {
    let (list, exists) = existsListArticles()
    XCTAssertTrue(exists)
    let rows = list.cells // testar celulas da list
    XCTAssertEqual(rows.count, 5)
  }

  func testGridCategories() {
    let (grid, exists) = existsGridCategory()
    XCTAssert(exists)

    let predicateRow = NSPredicate(format: "identifier CONTAINS '\(TestsIdentifier.rowCategories)_'")
    let rows = grid.staticTexts.containing(predicateRow)
    XCTAssertEqual(rows.count, listCategoriesMock.count)
  }

  func testFilterArticlesWhenTapTextField() {
    let predicateTextField = NSPredicate(format: "identifier == '\(TestsIdentifier.textFieldSearchNews)'")
    let textField = app.descendants(matching: .any).matching(predicateTextField).firstMatch
    textField.tap()
    textField.typeText("Apple")
    // ao digitar sera automaticamente chamado a função que esta no storeHome
    XCTAssertEqual(textField.value as? String, "Apple")

    // para esse teste dar certo precisa fechar o teclado
    // então apos digitar o texto e comparar se esta certo eu fecho ele
    // precisa estar declarado no text field o tipo de botão que no caso e done
    // .submitLabel(.done)
    let returnButton = app.buttons["Done"]
    returnButton.tap()

    let (list, exists) = existsListArticles()
    XCTAssertTrue(exists)
    let rows = list.cells
    XCTAssertEqual(rows.count, 3)
  }

  func testRequisitionofCategoryWhenSelectingAny() {
    let (grid, exists) = existsGridCategory()
    XCTAssert(exists)

    let text = grid.staticTexts[listCategoriesMock[1].title].firstMatch
    text.tap()
    let (list, _) = existsListArticles()
    let rows = list.cells

    XCTAssertEqual(rows.count, 2)
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
    let rowView = RowToCategories(category: listCategoriesMock[0], categoryIdSelected: listCategoriesMock[0].id)
    let view: UIView = UIHostingController(rootView: rowView).view
    assertSnapshot(of: view, as: .image)
  }
}

extension News_Cools_UITests {
  func existsListArticles() -> (view: XCUIElement, exists: Bool) {
    let predicateArticle = NSPredicate(format: "identifier == '\(TestsIdentifier.listArticles)'")
    let list = app.descendants(matching: .any).matching(predicateArticle).firstMatch
    let exists = list.waitForExistence(timeout: 5)

    return (list, exists)
  }

  func existsGridCategory() -> (view: XCUIElement, exists: Bool) {
    let predicateGrid = NSPredicate(format: "identifier == '\(TestsIdentifier.gridCategories)'")
    let grid = app.descendants(matching: .any).matching(predicateGrid).firstMatch
    let exists = grid.waitForExistence(timeout: 5)
    return (grid, exists)
  }
}
