//
//  Created by Ilya Sakalou on 6/30/20.
//  Copyright © 2020 Nirma. All rights reserved.
//

import Foundation
import XCTest
import WY_Mini_Tool_Engine
@testable import Mini_Tool

class SegmentsDataSourceTest: XCTestCase {
  let item1 = ColoredSegmentViewCellData(value: .magenta, stateColor: .green)
  let item2 = ColoredSegmentViewCellData(value: .brown, stateColor: .red)
  lazy var items = [item1, item2]
  let layout = UICollectionViewFlowLayout()
  lazy var collectionView = {
    UICollectionView(
      frame: CGRect(x: 0, y: 0, width: 100, height: 100),
      collectionViewLayout: self.layout
    )
  }
  
  func test_instantiate_storesItemsAndProvideRightCellsCount() {
    let layout = UICollectionViewFlowLayout()
    let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), collectionViewLayout: layout)
    
    let sut = makeSUT(items: items)
    let cellsCount = sut.collectionView(collectionView, numberOfItemsInSection: 0)
    
    XCTAssertEqual(sut.items.count, items.count)
    XCTAssertEqual(cellsCount, items.count)
  }
  
  func test_cellForItemAt_configuresCell() {
    let sut = makeSUT(items: items)
    let testCollection = collectionView()
    testCollection.register(ColoredSegmentViewCell.self)
    testCollection.dataSource = sut
    
    let cell0 = testCollection.cell(at: 0) as! ColoredSegmentViewCell
    let cell1 = testCollection.cell(at: 1) as! ColoredSegmentViewCell
    
    XCTAssertEqual(cell0.coloredPanelView.backgroundColor, items[0].value)
    XCTAssertEqual(cell0.backgroundColor, items[0].stateColor)
    XCTAssertEqual(cell1.coloredPanelView.backgroundColor, items[1].value)
    XCTAssertEqual(cell1.backgroundColor, items[1].stateColor)
  }
  
  func test_cellForItemAt_tryingToConfigureOutOfIndex_returnsEmptyCell() {
    let sut = makeSUT(items: items)
    let testCollection = collectionView()
    testCollection.register(ColoredSegmentViewCell.self)
    testCollection.dataSource = sut
    
    let cell = testCollection.cell(at: 2) as? ColoredSegmentViewCell
    
    XCTAssertNil(cell)
  }
  
  func test_updateSegmentAtIndex_updatesItem() {
    let sut = makeSUT(items: items)
    let testCollection = collectionView()
    testCollection.register(ColoredSegmentViewCell.self)
    testCollection.dataSource = sut
    
    let cell = testCollection.cell(at: 2) as? ColoredSegmentViewCell
    
    XCTAssertNil(cell)
  }
  
  func makeSUT(
    items: [ColoredSegmentViewCellData]
  ) -> DataSource<ColoredSegmentViewCellData, ColoredSegmentViewCell> {
    DataSource<ColoredSegmentViewCellData, ColoredSegmentViewCell>(items: items)
  }
}

// MARK: - UICollectionView
private extension UICollectionView {
  func cell(at row: Int) -> UICollectionViewCell? {
    dataSource?.collectionView(self, cellForItemAt: IndexPath(row: row, section: 0))
  }
}
