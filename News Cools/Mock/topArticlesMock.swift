//
//  topArticlesMock.swift
//  News Cools
//
//  Created by kenjimaeda on 28/08/23.
//

import Foundation

let topArticlesMock = TopArticlesModel(status: "ok", totalResults: 35, articles: [
  Articles(
    source: Source(id: "financial-times", name: "Financial Times"),
    author: "Ortenca Aliaj, Stephen Gandel",
    title: "Goldman Sachs sells financial planning unit as part of consumer retreat - Financial Times",
    description: "Deal comes as chief executive David Solomon unwinds botched foray into retail banking",
    url: "https://www.ft.com/content/0a1caac7-3713-4901-99a6-b6e60924a05f",
    urlToImage: nil,
    publishedAt: "2023-08-28T18:18:01Z",
    content: "What is included in my trial?\r\nDuring your trial you will have complete digital access to FT.com with everything in both of our Standard Digital and Premium Digital packages.\r\nStandard Digital includ… [+1494 chars]"
  ),

  Articles(
    source: Source(id: "abc-news", name: "ABC News"),
    author: "JOHN SEEWER Associated Press",
    title: "Joe the Plumber, who questioned Obama's tax policies during the 2008 campaign, has died at 49 - ABC News",
    description: "The man who became known as “Joe the Plumber” during the 2008 U.S. presidential election has died",
    url: "https://abcnews.go.com/US/wireStory/joe-plumber-questioned-obamas-tax-policies-2008-campaign-102623244",
    urlToImage: "https://s.abcnews.com/images/US/wirestory_71205f6f377129b3f1122f26ca238dc5_12x5_992.jpg",
    publishedAt: "2023-08-28T17:42:49Z",
    content: "TOLEDO, Ohio -- Samuel Joe Wurzelbacher, who was thrust into the political spotlight as Joe the Plumber after questioning Barack Obama about his economic policies during the 2008 presidential campaig… [+2212 chars]"
  )

])
