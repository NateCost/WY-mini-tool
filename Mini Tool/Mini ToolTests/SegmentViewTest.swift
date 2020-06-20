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
    let sut = makeSUT(segment)

    sut.configure(with: segment)

    XCTAssertEqual(sut.coloredPanelView.backgroundColor, segment.value)
  }
  
  func makeSUT(_ segment: ColoredSegment<ClassicColorProvider>) -> ColoredSegmentViewCell<ColoredSegment<ClassicColorProvider>> {
    Bundle.main.loadNibNamed(
      ColoredSegmentViewCell<ColoredSegment<ClassicColorProvider>>.reuseIdentifier,
      owner: nil,
      options: nil
    )?.first as! ColoredSegmentViewCell
  }
}
