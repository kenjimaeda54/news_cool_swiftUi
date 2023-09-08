# News Cools
App simples onde consulta as notícias recentes dos EUA,   noticias anteriores a um mês do dia atual e selecionar por categorias

## Feature
- Usei novamente o protocolo Representable, nele e possível usarmos um UKIT em Swiftui
- Precisei deste recurso para renderizar web view

```swift
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

//depois e so usar  na view
 var body: some View {
    NavigationStack {
      VStack {
        WebView(urlString: urlString)
      }
    }
    .toolbar {
      ToolbarItem(placement: .navigationBarLeading) {
        Button(action: handleBack) {
          Image(systemName: "chevron.left")
            .foregroundColor(
              ColorsApp.black100
            )
        }
        .accessibilityIdentifier(TestsIdentifier.backButtonDetailsScreen)
      }
    }
    .accessibilityIdentifier("DetailsScreen_\(urlString)")
  }

```
##
- Para realizar os testes em UI, ou seja, nas telas, precisei separa e identificar o alvo se era teste ou não
- Para testes realizei um mock do retorno dos meus json
- Para abstrair entre os serviços de ambiente, usei protocolo HttpClientProtocol, neste protocolo precisamos colocar todos os serviços que iremos usar
- Toda vez que o aplicativo no alvo de teste subi ira embutir variáveis de ambiente é nela que direciono qual ambiente devo usar
  

```swift
 
//HttpClientProtocol

enum HttpError: Error {
  case badURL, badResponse, errorEncodingData, noData, invalidURL, invalidRequest
}

protocol HttpClientProtocol {
  func fetchAllArticles(completion: @escaping (Result<[ArticlesIdentifiableModel], HttpError>) -> Void)
  func fetchSearchArticles(
    search: String,
    completion: @escaping (Result<[ArticlesIdentifiableModel], HttpError>) -> Void
  )
  func fetchCategoryArticles(
    category: String,
    completion: @escaping (Result<[ArticlesIdentifiableModel], HttpError>) -> Void
  )
}

// verifico se  ambiente teste ou real
class HttpClientFactory {
  static func create() -> HttpClientProtocol {
    let arguments = ProcessInfo.processInfo.environment["ENV"]

    return arguments == "TEST" ? MockHttpClient() : HttpClient()
  }
}

//HttpClient ambiente real
class HttpClient: HttpClientProtocol {
  func fetchCategoryArticles(
    category: String,
    completion: @escaping (Result<[ArticlesIdentifiableModel], HttpError>) -> Void
  ) {
    guard let url =
      URL(
        string: "https://newsapi.org/v2/top-headlines?country=us&category=\(category)&apiKey=e03da12b408445449464ceb16db4963a"
      )
    else {
      return completion(.failure(.badURL))
    }

    URLSession.shared.dataTask(with: url) { data, _, error in

      guard let data = data, error == nil else {
        return completion(.failure(.noData))
      }

      do {
        let response = try JSONDecoder().decode(TopArticlesModel.self, from: data)
        let articlesIdentifible = response.articles
          .map { ArticlesIdentifiableModel(id: UUID().uuidString, articles: $0) }
        completion(.success(articlesIdentifible))
      } catch {
        completion(.failure(.errorEncodingData))
      }
    }.resume()
  }

  func fetchAllArticles(completion: @escaping (Result<[ArticlesIdentifiableModel], HttpError>) -> Void) {
    guard let url =
      URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=e03da12b408445449464ceb16db4963a")
    else {
      return completion(.failure(.badURL))
    }

    URLSession.shared.dataTask(with: url) { data, _, error in

      guard let data = data, error == nil else {
        return completion(.failure(.noData))
      }

      do {
        let response = try JSONDecoder().decode(TopArticlesModel.self, from: data)
        let articlesIdentifible = response.articles
          .map { ArticlesIdentifiableModel(id: UUID().uuidString, articles: $0) }
        completion(.success(articlesIdentifible))
      } catch {
        completion(.failure(.errorEncodingData))
      }
    }.resume()
  }

  func fetchSearchArticles(
    search: String,
    completion: @escaping (Result<[ArticlesIdentifiableModel], HttpError>) -> Void
  ) {
    guard let url =
      URL(
        string: "https://newsapi.org/v2/everything?q=\(search)&from=\(returnMonthLast())&sortBy=popularity&apiKey=e03da12b408445449464ceb16db4963a"
      )
    else {
      return completion(.failure(.badURL))
    }

    URLSession.shared.dataTask(with: url) { data, _, error in

      guard let data = data, error == nil else {
        return completion(.failure(.noData))
      }

      do {
        let response = try JSONDecoder().decode(TopArticlesModel.self, from: data)
        let articlesIdentifible = response.articles
          .map { ArticlesIdentifiableModel(id: UUID().uuidString, articles: $0) }
        completion(.success(articlesIdentifible))
      } catch {
        completion(.failure(.errorEncodingData))
      }
    }.resume()
  }
}


// MockHttpClient ambiente teste
// aqui faço fetch nos mocks
class MockHttpClient: HttpClientProtocol, Mockable {
  func fetchCategoryArticles(
    category: String,
    completion: @escaping (Result<[ArticlesIdentifiableModel], HttpError>) -> Void
  ) {
    let response = loadJson(filename: "CategoryArticles", type: TopArticlesModel.self)
    let articles = response.articles.map { ArticlesIdentifiableModel(id: UUID().uuidString, articles: $0) }
    completion(.success(articles))
  }

  func fetchAllArticles(completion: @escaping (Result<[ArticlesIdentifiableModel], HttpError>) -> Void) {
    let response = loadJson(filename: "TopArticles", type: TopArticlesModel.self)
    let articles = response.articles.map { ArticlesIdentifiableModel(id: UUID().uuidString, articles: $0) }
    completion(.success(articles))
  }

  func fetchSearchArticles(
    search: String,
    completion: @escaping (Result<[ArticlesIdentifiableModel], HttpError>) -> Void
  ) {
    let response = loadJson(filename: "FilterArticles", type: TopArticlesModel.self)
    let articles = response.articles.map { ArticlesIdentifiableModel(id: UUID().uuidString, articles: $0) }
    completion(.success(articles))
  }
}

//Store faz a camada entre serviço e a tela, para facilitar as coisas coloca a camada logica da tela especifica aqui
// as duas funções handleSearchArticles e handleTapCategory, são logicas de implementação da tela home
class StoreHome: ObservableObject {
  @Published var articles: [ArticlesIdentifiableModel] = []
  @Published var loading = LoadingState.loading
  private let httpClient: HttpClientProtocol

  init(httpClient: HttpClientProtocol = HttpClientFactory.create()) {
    self.httpClient = httpClient
  }

  func fetchArticles() {
    httpClient.fetchAllArticles { result in

      switch result {
      case let .success(articles):

        DispatchQueue.main.async {
          self.loading = LoadingState.success
          self.articles = articles
        }

      case let .failure(error):
        DispatchQueue.main.async {
          self.loading = LoadingState.failure
        }
      }
    }
  }

  func fetchSearchArticles(_ word: String) {
    httpClient.fetchSearchArticles(search: word) { result in

      switch result {
      case let .success(articles):

        DispatchQueue.main.async {
          self.loading = LoadingState.success
          self.articles = articles
        }

      case let .failure(error):
        DispatchQueue.main.async {
          self.loading = LoadingState.failure
        }
      }
    }
  }

  func fetchArticlesByCategory(_ category: String) {
    httpClient.fetchCategoryArticles(category: category) { result in

      switch result {
      case let .success(articles):

        DispatchQueue.main.async {
          self.loading = LoadingState.success
          self.articles = articles
        }

      case let .failure(error):
        DispatchQueue.main.async {
          self.loading = LoadingState.failure
        }
      }
    }
  }


  func handleSearchArticles(valueSearch newValue: String, valueInput: String) {
    if valueInput.count > 3 && valueInput.count % 4 == 0 {
      fetchSearchArticles(newValue)
    }
  }

  func handleTapCategory(_ category: String) {
    fetchArticlesByCategory(category)
  }
}

// na tela de screen so implemento o protocolo
@ObservedObject private var storeHome = StoreHome(httpClient: HttpClientFactory.create())

```


##

- Para realizar teste visual das UI pode usar snapshot, assim diminui linhas de complexidade, também aumenta a confidencialidade, pois snashopt ira testar píxel por píxel
- [SnashotTesting](https://github.com/pointfreeco/swift-snapshot-testing) preciso sempre que usar alguma biblioteca, direciona para o alvo que desejo trabalhar com ela, essa no caso precisa estar apenas no alvo de teste, para verificar isso vai em Targets -> Build Phases -> Link Binary With Libraries
- Lembrasse sempre que os alvos são distintos, então quando estiver testando as suas funções não irão encontrar metodos que estiver no alvo principal ou pacotes
- Para usar esse pacote e bem simples [tutorial](https://www.kodeco.com/24426963-snapshot-testing-tutorial-for-swiftui-getting-started) pode seguir esse tutorial ou exemplo abaixo

```swift
// primerio retiro uma foto da view em questâo como artigo acima]
// na primeria vez ira falhar pois precisa da referencia, depois caso a view esteja conforme a imagme ira funcionar
 func testSnapshotRowCategories() {
    let rowView = RowToCategories(category: listCategoriesMock[0], categoryIdSelected: listCategoriesMock[0].id)
    let view: UIView = UIHostingController(rootView: rowView).view
    assertSnapshot(of: view, as: .image)
  }




```

##
- Quando for realizar algum teste, com o keyboard aberto precisa fechar ele em seguida, pois as views que estão cobertas por ele não ira conseguir ser vistas
- Repara que pego o botão done do teclado, isso e possível, porque no textField possui a propriedade .submitLabel(.done),  inclusive tenho que testa se ao clicar em done quando estiver no ambiente sem teste ira fechar o teclado
- Esse teste automaticamente digitava Apple no text field devido à propriedade  textField.typeText("Apple"), ao digitar aciona a função que coloquei no storeHome e assim filtra as listas do meu mock
- Assim  garanto que ao digitar algo no text field iria filtra a lista conforme os mocks que determinei, nesse caso era arquivo de mock FilterArticles que possui 3 dados
- Quando usa tap gesture em suas views pode simples dar match com um texto ou a view, o tap que ira funcionar, já que o gesture dá acesso a tap

```swift
func testFilterArticlesWhenTapTextField() {
    let predicateTextField = NSPredicate(format: "identifier == '\(TestsIdentifier.textFieldSearchNews)'")
    let textField = app.descendants(matching: .any).matching(predicateTextField).firstMatch
    textField.tap()
    textField.typeText("Apple")
 
    XCTAssertEqual(textField.value as? String, "Apple")

    let returnButton = app.buttons["Done"]
    returnButton.tap()

    let (list, exists) = existsListArticles()
    XCTAssertTrue(exists)
    let rows = list.cells
    XCTAssertEqual(rows.count, 3)
  }

//home screen
RowToCategories(category: categorie, categoryIdSelected: categorySelected)
                .accessibilityIdentifier("\(TestsIdentifier.rowCategories)_\(categorie.id)")
                .gesture(
                  TapGesture()
                    .onEnded { _ in
                      storeHome.handleTapCategory(categorie.title)
                      categorySelected = categorie.id
                    }
                )

// test
 func navigateDetailsScreen() {
    let predicateArticle = NSPredicate(format: "identifier == '\(TestsIdentifier.listArticles)'")
    let list = app.descendants(matching: .any).matching(predicateArticle).firstMatch
    let singleRow = list.staticTexts["Francis Suarez ends campaign for Republican presidential nomination - CNN"]
      .firstMatch

    singleRow.tap()
  }

```



