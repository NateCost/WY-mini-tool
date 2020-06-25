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
    let routerOutput = BreachRouterOutputMock<ColoredSegment>(segmentsToBreach: [])
    let sut = makeSUT(output: routerOutput)
    
    sut.finish()
    
    XCTAssert(routerOutput.finished)
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
    let routerOutput = BreachRouterOutputMock<ColoredSegment>(segmentsToBreach: segmentsToBreach)
    let sut = makeSUT(output: routerOutput)
    
    segment.setState(.failed)
    sut.segmentUpdated(segment)
    
    XCTAssertEqual(routerOutput.updatedSegment, segment)
  }
  
  func makeSUT(
    output: BreachRouterOutputMock<ColoredSegment> = BreachRouterOutputMock<ColoredSegment>(segmentsToBreach: [])
  ) -> BreachRouter<ColoredSegment, BreachRouterOutputMock<ColoredSegment>> {
    let router = BreachRouter<ColoredSegment, BreachRouterOutputMock<ColoredSegment>>()
    router.output = output
    return router
  }
}
