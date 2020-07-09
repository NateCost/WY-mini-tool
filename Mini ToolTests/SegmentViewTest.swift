//
//  Created by Ilya Sakalou on 5/8/20.
//  Copyright © 2020 Nirma. All rights reserved.
//

import Foundation
import XCTest
import WY_Mini_Tool_Engine
@testable import Mini_Tool

class ColoredSegmentViewCellTest: XCTestCase {
  func test_configure_setColoredPanelColor() {
    let segment = ColoredSegment(.black, colorProvider: ClassicColorProvider())
    let model = ColoredSegmentViewCellData(value: segment.value, stateColor: segment.color)
    let sut = makeSUT()

    sut.configure(with: model)

    XCTAssertEqual(sut.coloredPanelView!.backgroundColor, segment.value)
    XCTAssertEqual(sut.backgroundColor, segment.color)
  }
  
  func makeSUT() -> ColoredSegmentViewCell {
    Bundle.main.loadNibNamed(
      ColoredSegmentViewCell.reuseIdentifier,
      owner: nil,
      options: nil
    )?.first as! ColoredSegmentViewCell
  }
}

class StringSegmentViewCellTest: XCTestCase {
  func test_configure_setStringLabelText() {
    let segment = StringSegment("1", colorProvider: ClassicColorProvider())
    let model = StringSegmentViewCellData(value: segment.value, stateColor: segment.color)
    let sut = makeSUT()
    
    sut.configure(with: model)
    
    XCTAssertEqual(sut.valueLabel.text, segment.value)
    XCTAssertEqual(sut.backgroundColor, segment.color)
  }
  
  func makeSUT() -> StringSegmentViewCell {
    Bundle.main.loadNibNamed(
      StringSegmentViewCell.reuseIdentifier,
      owner: nil,
      options: nil
    )?.first as! StringSegmentViewCell
  }
}
