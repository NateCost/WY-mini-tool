//
//  Created by Ilya Sakalou on 6/1/20.
//  Copyright © 2020 Nirma. All rights reserved.
//

import Foundation
import XCTest
import WY_Mini_Tool_Engine
@testable import Mini_Tool

class BreachComposerTest: XCTestCase {
  func test_composeBreachComponents_allComponentsAreBinded() {
    let segmentsToBreach = [
      makeColoredSegment(color: .black),
      makeColoredSegment(color: .brown),
    ]
    let segmentsToChoose = [
      makeColoredSegment(color: .black),
      makeColoredSegment(color: .red),
      makeColoredSegment(color: .brown),
      makeColoredSegment(color: .gray)
    ]
    let router = BreachRouter<ColoredSegment, BreachViewController>()
    let input = BreachInput(
      router: router,
      segmentsToBreach: segmentsToBreach,
      segmentsToChoose: segmentsToChoose
    )
    
    let sut = ColoredBreachComposer.compose(withInput: input)
    
    XCTAssertNotNil(sut.viewController.router)
    XCTAssertEqual(sut.viewController.router?.viewInput, sut.viewController)
  }
  
  func makeColoredSegment(
    color: UIColor,
    colorProvider: ClassicColorProvider = ClassicColorProvider()
  ) -> ColoredSegment {
    ColoredSegment(color, colorProvider: colorProvider)
  }
}
