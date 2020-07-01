//
//  Created by Ilya Sakalou on 6/23/20.
//  Copyright © 2020 Nirma. All rights reserved.
//

import Foundation
import XCTest
import WY_Mini_Tool_Engine
@testable import Mini_Tool

class BreachPresenterTest: XCTestCase {
  let segment1 = ColoredSegment(.black, colorProvider: TransluentColorProvider())
  let segment2 = ColoredSegment(.red, colorProvider: TransluentColorProvider())
  let viewInputMock = BreachViewInputMock()
  
  func test_instantiate_setSegmentsToBreach_storesSegments() {
    let sut = makeSUT(segmentsToBreach: [segment1, segment2])
    XCTAssertEqual(sut.segmentsToBreach, [segment1, segment2])
  }
  
  func test_finishBreach_triggersViewInputFinish() {
    let sut = makeSUT(segmentsToBreach: [segment1, segment2])
    sut.view = viewInputMock
    
    sut.finishFlow()
    
    XCTAssertTrue(viewInputMock.finished)
  }
  
  func test_didUpdateSegment_sendsSegmentToViewDataSource() {
    let sut = makeSUT(segmentsToBreach: [segment1, segment2])
    sut.view = viewInputMock
    segment1.setState(.failed)

    sut.didUpdateSegment(segment1)

    XCTAssertTrue(viewInputMock)
  }
  
  func makeSUT(
    segmentsToBreach: [ColoredSegment]
  ) -> BreachPresenter<ColoredSegment, ColoredSegmentViewCellData, ColoredSegmentViewCell> {
    BreachPresenter<
      ColoredSegment,
      ColoredSegmentViewCellData, ColoredSegmentViewCell
    >(
      segmentsToBreach: segmentsToBreach,
      collectionViewDataSource: DataSource<ColoredSegmentViewCellData, ColoredSegmentViewCell>()
    )
  }
}
