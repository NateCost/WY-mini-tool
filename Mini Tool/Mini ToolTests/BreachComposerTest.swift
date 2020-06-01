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
      ColoredSegment(.black),
      ColoredSegment(.brown),
    ]
    let segmentsToChoose = [
      ColoredSegment(.black),
      ColoredSegment(.red),
      ColoredSegment(.brown),
      ColoredSegment(.gray)
    ]
    let router = BreachRouter<ColoredSegment, BreachViewController>()
    let input = BreachInput(
      router: router,
      segmentsToBreach: segmentsToBreach,
      segmentsToChoose: segmentsToChoose
    )
    
    let sut = BreachComposer.compose(withInput: input)
    
    XCTAssertNotNil(sut.viewController.router)
    XCTAssertEqual(sut.viewController.router?.viewInput, sut.viewController)
  }
}
