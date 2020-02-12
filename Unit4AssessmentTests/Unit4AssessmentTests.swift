//
//  Unit4AssessmentTests.swift
//  Unit4AssessmentTests
//
//  Created by Alex Paul on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import XCTest
@testable import Unit4Assessment

class Unit4AssessmentTests: XCTestCase {

    func testJSONData() {
        let jsonData = """
[{
  "id": "1",
  "quizTitle": "What is the difference between Synchronous & Asynchronous task",
  "facts": [
    "Synchronous: waits until the task have completed",
    "Asynchronous: completes a task in the background and can notify you when complete"
  ]
},
{
  "id": "2",
  "quizTitle": "What is Enum or Enumerations",
  "facts": [
    "contains a group of related values",
    "enumerations define a finite number of states, and can bundle associated values with each individual state, you can use them to model the state of your app and its internal processes"
  ]
}]

""".data(using: .utf8)!
        
        let firstQuizTitle = "What is the difference between Synchronous & Asynchronous task"

        do {
            let cards = try JSONDecoder().decode([Cards].self, from: jsonData)
            let id = cards.first?.quizTitle
            XCTAssertEqual(firstQuizTitle, id)
        } catch {
            XCTFail("decoding error: \(error)")
        }
        
    }
}
