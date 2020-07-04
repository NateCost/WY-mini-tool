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
    
    let selectionDataSource = ColoredDataSource()
    let breachingDataSource = ColoredDataSource()
    let routerOutput = ColoredPresenter(
      segmentsToBreach: segmentsToBreach,
      segmentsToChoose: segmentsToChoose,
      selectCollectionViewDataSource: selectionDataSource,
      breachViewDataSource: breachingDataSource,
      selectionCallback: { _ in }
    )
    let router = BreachRouter<ColoredSegment, ColoredPresenter>()
    router.output = routerOutput

    let input = BreachInput(
      output: routerOutput,
      selectionViewDataSource: selectionDataSource,
      breachViewDataSource: breachingDataSource,
      cellType: ColoredSegmentViewCell.self
    )
    
    let sut = BreachComposer.compose(withInput: input)
    routerOutput.view = sut.viewController
    
    XCTAssertNotNil(sut.viewController.output)
  }
  
  func makeColoredSegment(
    color: UIColor,
    colorProvider: ClassicColorProvider = ClassicColorProvider()
  ) -> ColoredSegment {
    ColoredSegment(color, colorProvider: colorProvider)
  }
}
