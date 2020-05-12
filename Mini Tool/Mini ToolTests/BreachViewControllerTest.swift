//
//  Mini_ToolTests.swift
//  Mini ToolTests
//
//  Created by Ilya Sakalou on 5/3/20.
//  Copyright © 2020 Nirma. All rights reserved.
//

import Foundation
import XCTest
@testable import Mini_Tool

class BreachViewContllerTest: XCTestCase {
  func test_viewDidLoad_noSegmentsToBreach_updatesStatus() {
    let sut = BreachViewController(segmentsToBreach: [], segmentsToChoose: [])
    
    _ = sut.view
    
    XCTAssertEqual(sut.status, BreachStatus.noSegmentsToBreach)
  }
  
  func test_viewDidLoad_noSegmentsToChoose_updatesStatus() {
    let segment = PixelMatrixSegment(value: "S1")
    let sut = BreachViewController(
      segmentsToBreach: [segment],
      segmentsToChoose: []
    )
    
    _ = sut.view
    
    XCTAssertEqual(sut.status, BreachStatus.noSegmentsToSelect)
  }
  
  func test_viewDidLoad_withSegmentsToBreachAndToChoose_updatesStatus() {
    let segment = PixelMatrixSegment(value: "S1")
    let sut = BreachViewController(
      segmentsToBreach: [segment],
      segmentsToChoose: [segment]
    )
    
    _ = sut.view
    
    XCTAssertEqual(sut.status, BreachStatus.breaching)
  }
}
