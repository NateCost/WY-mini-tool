//
//  Created by Ilya Sakalou on 5/3/20.
//  Copyright © 2020 Nirma. All rights reserved.
//

import Foundation
import XCTest
import WY_Mini_Tool_Engine
@testable import Mini_Tool

class BreachViewControllerTest: XCTestCase {
  func test_reloadSelectSegment_changesRightCellUI() {
    let colorProvider = ClassicColorProvider()
    let segment1 = makeColoredSegment(color: .red, colorProvider: colorProvider)
    let model1 = ColoredSegmentViewCellData.make(
      value: segment1.value, stateColor: segment1.color
    )
    let selectionViewDataSource = ColoredDataSource(items: [model1])
    let sut = makeSUT(
      segmentsToChoose: [segment1],
      selectionViewDataSource: selectionViewDataSource
    )
    let updatedModel = ColoredSegmentViewCellData.make(
      value: .brown, stateColor: .darkGray
    )
    selectionViewDataSource.update(updatedModel, at: 0)
    
    let cell0 = sut.selectionCollectionView.cell(at: 0) as! ColoredSegmentViewCell
    sut.reloadSelectionSegment(at: IndexPath(row: 0, section: 0))
    
    XCTAssertEqual(cell0.backgroundColor, .darkGray)
    XCTAssertEqual(cell0.coloredPanelView.backgroundColor, .brown)
  }
  
  func test_finishFlow_makesSelectionCollectionViewHidden() {
    let colorProvider = ClassicColorProvider()
    let redSegment = makeColoredSegment(color: .red, colorProvider: colorProvider)
    let sut = makeSUT(segmentsToChoose: [redSegment])
    
    sut.finishFlow()
    
    XCTAssertTrue(sut.selectionCollectionView.isHidden)
  }
  
  // MARK: - Helpers
  func makeSUT(
    segmentsToBreach: [ColoredSegment] = [],
    segmentsToChoose: [ColoredSegment] = [],
    selectionViewDataSource: ColoredDataSource = ColoredDataSource(),
    breachViewDataSource: ColoredDataSource = ColoredDataSource()
  ) -> BreachViewController {
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
