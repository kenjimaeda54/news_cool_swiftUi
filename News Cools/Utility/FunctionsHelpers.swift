//
//  FunctionsHelpers.swift
//  News Cools
//
//  Created by kenjimaeda on 01/09/23.
//

import Foundation

func returnDateStringRelative(_ date: String) -> String {
  let formaterStringToDate = ISO8601DateFormatter()
  let date = formaterStringToDate.date(from: date)
  let formatter = RelativeDateTimeFormatter()
  formatter.unitsStyle = .full
  let relativeDate = formatter.localizedString(for: date ?? Date(), relativeTo: Date())
  return relativeDate
}

func returnMonthLast() -> String {
  let dateFormatter = DateFormatter()
  dateFormatter.dateFormat = "yyyy-MM-dd"

  guard let date = Calendar.current.date(byAdding: .month, value: -1, to: Date()) else {
    return dateFormatter.string(from: Date())
  }
  return dateFormatter.string(from: date)
}
