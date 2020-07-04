//
//  Created by Ilya Sakalou on 5/3/20.
//  Copyright © 2020 Nirma. All rights reserved.
//

import Foundation
import XCTest
import WY_Mini_Tool_Engine
@testable import Mini_Tool

class BreachViewControllerTest: XCTestCase {
//  func test_viewDidLoad_with2SegmentsToBreach_segmentsToBreachStackHasProperColors() {
//    let sut = makeSUT(
//      segmentsToBreach: [
//        makeColoredSegment(color: .black),
//        makeColoredSegment(color: .brown)
//      ]
//    )
//    XCTAssertEqual(getBreachSegment(sut: sut, at: 0)!.coloredPanelView!.backgroundColor, .black)
//    XCTAssertEqual(getBreachSegment(sut: sut, at: 1)!.coloredPanelView!.backgroundColor, .brown)
//  }
  
//  func test_hasSegmentsToBreach_setNewStateToOneSegment_changesState() {
//    let colorProvider = ClassicColorProvider()
//    let blackSegment = makeColoredSegment(color: .black, colorProvider: colorProvider)
//    let blueSegment = makeColoredSegment(color: .blue)
//    let segmentsToBreach = [blackSegment, blueSegment]
//    let sut = makeSUT(segmentsToBreach: segmentsToBreach, segmentsToChoose: [], selection: { _ in })
//
//    blackSegment.setState(.selected)
//
//    XCTAssertEqual(sut.segmentsToBreach[0].state, .selected)
//  }
  
  func test_hasSegmentsToChoose_updateSegmentState_changesSegmentBackgroundColor() {
    let colorProvider = ClassicColorProvider()
    let redSegment = makeColoredSegment(color: .red, colorProvider: colorProvider)
    let sut = makeSUT(segmentsToChoose: [redSegment])
    
    sut.finishFlow()
    
    XCTAssertTrue(sut.selectionCollectionView.isHidden)
  }
  
  // MARK: - Helpers
  func makeSUT(
    segmentsToBreach: [ColoredSegment] = [],
    segmentsToChoose: [ColoredSegment] = []
  ) -> BreachViewController {
    let selectionViewDataSource = ColoredDataSource()
    let breachViewDataSource = ColoredDataSource()
    
    let presenter = ColoredPresenter(
      segmentsToBreach: segmentsToBreach,
      segmentsToChoose: segmentsToChoose,
      selectCollectionViewDataSource: selectionViewDataSource,
      breachViewDataSource: breachViewDataSource,
      selectionCallback: { _ in }
    )
    let sut = BreachViewController(
      output: presenter,
      cellType: ColoredSegmentViewCell.self,
      selectionDataSource: selectionViewDataSource,
      breachDataSource: breachViewDataSource
    )
    _ = sut.view
    return sut
  }
  
  func makeColoredSegment(
    color: UIColor,
    colorProvider: ClassicColorProvider = ClassicColorProvider()
  ) -> ColoredSegment {
    ColoredSegment(color, colorProvider: colorProvider)
  }
}

// MARK: - UICollectionView
private extension UICollectionView {
  func cell(at row: Int) -> UICollectionViewCell? {
    dataSource?.collectionView(
      self,
      cellForItemAt: IndexPath(row: row, section: 0)
    )
  }
  
  func select(row: Int) {
    delegate?.collectionView?(self, didSelectItemAt: IndexPath(row: row, section: 0))
  }
}
