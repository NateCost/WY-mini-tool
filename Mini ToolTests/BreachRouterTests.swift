//
//  Created by Ilya Sakalou on 5/28/20.
//  Copyright © 2020 Nirma. All rights reserved.
//

import Foundation
import XCTest
import WY_Mini_Tool_Engine
@testable import Mini_Tool

class BreachRouterTests: XCTestCase {
  typealias ColoredBreachRouterOutputMock = BreachRouterOutputMock<
    ColoredSegment, ColoredSegmentViewCellData, ColoredSegmentViewCell
  >
  typealias ColoredDataSource = DataSource<ColoredSegmentViewCellData, ColoredSegmentViewCell>
  
  func test_finish_executesRouterInputFinish() {
    let routerOutput = ColoredBreachRouterOutputMock(segmentsToBreach: [])
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
    let routerOutput = ColoredBreachRouterOutputMock(segmentsToBreach: segmentsToBreach)
    let sut = makeSUT(output: routerOutput)
    
    segment.setState(.failed)
    sut.segmentUpdated(segment)
    
    XCTAssertEqual(routerOutput.updatedSegment, segment)
  }
  
  func makeSUT(
    output: ColoredBreachRouterOutputMock = ColoredBreachRouterOutputMock(segmentsToBreach: [])
  ) -> BreachRouter<ColoredSegment, ColoredBreachRouterOutputMock> {
    let router = BreachRouter<ColoredSegment, ColoredBreachRouterOutputMock>()
    router.output = output
    return router
  }
}
