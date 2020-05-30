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
    let viewInput = BreachViewInputSpy(segmentsToBreach: [])
    let sut = makeSUT(viewInput: viewInput)
    
    sut.finish()
    
    XCTAssert(viewInput.finished)
  }
  
  func test_handleSegment_savesRoutedSegment() {
    let segment = ColoredSegment(.black)
    let sut = makeSUT()
    
    sut.handleSegment(segment, selectionCallback: { selection, segment in })
    
    XCTAssertEqual(sut.routedSegment, segment)
  }
  
  func test_updateSegment_viewInputUpdatesState() {
    let segment = ColoredSegment(.black)
    let segmentsToBreach = [segment]
    let viewInput = BreachViewInputSpy(
      segmentsToBreach: segmentsToBreach
    )
    let sut = makeSUT(viewInput: viewInput)
    
    sut.updateSegment(segment, with: .failed)
    
    XCTAssertEqual(viewInput.segment, segment)
    XCTAssertEqual(viewInput.state, .failed)
  }
  
  class BreachViewInputSpy: BreachViewInput {
    typealias Segment = ColoredSegment
    var segmentsToBreach: [Segment]
    var finished = false
    var state: SegmentState?
    var segment: Segment?
    
    init(segmentsToBreach: [Segment]) {
      self.segmentsToBreach = segmentsToBreach
    }
    
    func finishFlow() {
      finished = true
    }
    
    func setState(_ state: SegmentState, for segment: Segment) {
      self.state = state
      self.segment = segment
    }
  }
  
  func makeSUT(viewInput: BreachViewInputSpy = BreachViewInputSpy(segmentsToBreach: [])) -> BreachRouter<ColoredSegment, BreachViewInputSpy> {
    BreachRouter(viewInput: viewInput)
  }
}
