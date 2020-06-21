//
//  Created by Ilya Sakalou on 5/8/20.
//  Copyright © 2020 Nirma. All rights reserved.
//

import Foundation
import XCTest
import WY_Mini_Tool_Engine
@testable import Mini_Tool

class SegmentViewCellTest: XCTestCase {
  func test_configure_setColoredPanelColor() {
    let segment = ColoredSegment(.black, colorProvider: ClassicColorProvider())
    let model = ColoredSegmentViewCellData(value: segment.value, stateColor: segment.color)
    let sut = makeSUT()

    sut.configure(with: model)

    XCTAssertEqual(sut.coloredPanelView!.backgroundColor, segment.value)
  }
  
  func makeSUT() -> ColoredSegmentViewCell {
    Bundle.main.loadNibNamed(
      ColoredSegmentViewCell.reuseIdentifier,
      owner: nil,
      options: nil
    )?.first as! ColoredSegmentViewCell
  }
}
