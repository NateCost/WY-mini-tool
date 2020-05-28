//
//  BreachRouterTests.swift
//  Mini ToolTests
//
//  Created by Ilya Sakalou on 5/28/20.
//  Copyright © 2020 Nirma. All rights reserved.
//

import Foundation
import XCTest
import WY_Mini_Tool_Engine
@testable import Mini_Tool

class BreachRouterTests: XCTestCase {
  func test_finish_executesViewInputFinish() {
    let viewInput = BreachViewInputSpy()
    let sut = makeSUT(viewInput: viewInput)
    
    sut.finish()
    
    XCTAssert(viewInput.finished)
  }
  
  class BreachViewInputSpy: BreachViewInput {
    var finished = false
    
    func finishFlow() {
      finished = true
    }
  }
  
  func makeSUT(viewInput: BreachViewInputSpy = BreachViewInputSpy()) -> BreachRouter {
    BreachRouter(viewInput: viewInput)
  }
}
