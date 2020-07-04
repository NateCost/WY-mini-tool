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
    
    let selectionDataSource = DataSource<ColoredSegmentViewCellData, ColoredSegmentViewCell>()
    let breachingDataSource = DataSource<ColoredSegmentViewCellData, ColoredSegmentViewCell>()
    let routerOutput = BreachPresenter<
      ColoredSegment, ColoredSegmentViewCellData, ColoredSegmentViewCell
    >(
      segmentsToBreach: segmentsToBreach,
      segmentsToChoose: segmentsToChoose,
      collectionViewDataSource: selectionDataSource,
      breachViewDataSource: breachingDataSource
    )
    let router = BreachRouter<
      ColoredSegment,
      BreachPresenter<ColoredSegment, ColoredSegmentViewCellData, ColoredSegmentViewCell>
    >()
    router.output = routerOutput

    let input = BreachInput(
      output: routerOutput,
      segmentsToBreach: segmentsToBreach,
      segmentsToChoose: segmentsToChoose
    )
    
    let sut = ColoredBreachComposer.compose(withInput: input)
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
