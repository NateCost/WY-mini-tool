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
    let segment = ColoredSegment(.black, colorProvider: ClassicColorProvider())
    let sut = makeSUT()
    
    sut.handleSegment(segment, selectionCallback: { selection, segment in })
    
    XCTAssertEqual(sut.routedSegment, segment)
  }
  
  func test_updateSegment_viewInputUpdatesState() {
    let segment = ColoredSegment(.black, colorProvider: ClassicColorProvider())
    let segmentsToBreach = [segment]
    let viewInput = BreachViewInputSpy(segmentsToBreach: segmentsToBreach)
    let sut = makeSUT(viewInput: viewInput)
    
    segment.setState(.failed)
    sut.segmentUpdated(segment)
    
    XCTAssertEqual(viewInput.updatedSegment, segment)
  }
  
  class BreachViewInputSpy: BreachViewInput {
    typealias Segment = ColoredSegment
    var segmentsToBreach: [Segment]
    var finished = false
    var updatedSegment: Segment?
    
    init(segmentsToBreach: [Segment]) {
      self.segmentsToBreach = segmentsToBreach
    }
    
    func finishFlow() {
      finished = true
    }
    
    func didUpdateSegment(_ segment: Segment) {
      updatedSegment = segment
    }
  }
  
  func makeSUT(
    viewInput: BreachViewInputSpy = BreachViewInputSpy(segmentsToBreach: [])
  ) -> BreachRouter<ColoredSegment, BreachViewInputSpy> {
    let router = BreachRouter<ColoredSegment, BreachViewInputSpy>()
    router.viewInput = viewInput
    return router
  }
}
