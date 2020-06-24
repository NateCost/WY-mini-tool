//
//  Created by Ilya Sakalou on 6/23/20.
//  Copyright © 2020 Nirma. All rights reserved.
//

import Foundation
import XCTest
import WY_Mini_Tool_Engine
@testable import Mini_Tool

class BreachPresenterTest: XCTestCase {
  func test_instantiate_setSegmentsToBreach_storesSegments() {
    let segmentsFactory = ColoredSegmentFactory(colorProvider: TransluentColorProvider())
    let segments = [
      segmentsFactory.makeSegment(value: .black),
      segmentsFactory.makeSegment(value: .red)
    ]
    
    let sut = makeSUT(segmentsToBreach: segments)
    
    XCTAssertEqual(sut.segmentsToBreach, segments)
  }
  
  func makeSUT(segmentsToBreach: [ColoredSegment]) -> BreachPresenter<BreachViewInputMock, ColoredSegment> {
    BreachPresenter<BreachViewInputMock, ColoredSegment>(segmentsToBreach: segmentsToBreach)
  }
}
