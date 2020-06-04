//
//  Created by Ilya Sakalou on 5/3/20.
//  Copyright © 2020 Nirma. All rights reserved.
//

import Foundation
import XCTest
import WY_Mini_Tool_Engine
@testable import Mini_Tool

class BreachViewContllerTest: XCTestCase {
  func test_viewDidLoad_noSegmentsToChoose_updatesStatus() {
    let sut = makeSUT(segmentsToBreach: [ColoredSegment(.black, colorProvider: ClassicColorProvider())])
    XCTAssertEqual(sut.status, BreachStatus.noSegmentsToSelect)
  }
  
  func test_viewDidLoad_withSegmentsToBreachAndToChoose_updatesStatus() {
    let sut = makeSUT(
      segmentsToBreach: [makeColoredSegment(color: .black)],
      segmentsToChoose: [makeColoredSegment(color: .black)]
    )
    XCTAssertEqual(sut.status, BreachStatus.breaching)
  }
  
  func test_viewDidLoad_withNoSegmentsToBreach() {
    let sut = makeSUT(segmentsToBreach: [])
    XCTAssertEqual(sut.segmentsToBreachStackView.subviews.count, 0)
    XCTAssertEqual(sut.status, BreachStatus.noSegmentsToBreach)
  }
  
  func test_viewDidLoad_with2SegmentsToBreach_segmentsToBreachStackHas2Subviews() {
    let sut = makeSUT(
      segmentsToBreach: [
        makeColoredSegment(color: .black),
        makeColoredSegment(color: .brown)
      ]
    )
    XCTAssertEqual(sut.segmentsToBreachStackView.subviews.count, 2)
  }
  
  func test_viewDidLoad_collectionViewLoadsSegments() {
    let sut = makeSUT(
      segmentsToBreach: [],
      segmentsToChoose: [
        makeColoredSegment(color: .black),
        makeColoredSegment(color: .brown)
      ]
    )
    let cell1 = sut.segmentsToChooseCollectionView.cell(at: 0) as? SegmentViewCell
    XCTAssertNotNil(cell1)
    XCTAssertEqual(cell1?.color, .black)
    
    let cell2 = sut.segmentsToChooseCollectionView.cell(at: 1) as? SegmentViewCell
    XCTAssertNotNil(cell2)
    XCTAssertEqual(cell2?.color, .brown)
  }
  
  func test_optionSelection_notifiesDelegate() {
    var selectedSegments: [ColoredSegment<ClassicColorProvider>] = []
    
    let sut = makeSUT(
      segmentsToBreach: [makeColoredSegment(color: .black)],
      segmentsToChoose: [
        makeColoredSegment(color: .black),
        makeColoredSegment(color: .brown)
      ]
    ) { selectedSegments.append($0) }
    
    sut.segmentsToChooseCollectionView.select(row: 0)
    
    XCTAssertEqual(selectedSegments.count, 1)
    XCTAssertEqual(selectedSegments[0].value, makeColoredSegment(color: .black).value)
  }
  
  func test_hasSegmentsToChoose_persistSameStates() {
    let blackSegment = makeColoredSegment(color: .black)
    blackSegment.setState(.passed)
    let blueSegment = makeColoredSegment(color: .blue)
    blackSegment.setState(.none)
    let segmentsToChoose = [blackSegment, blueSegment]
    
    let sut = makeSUT(segmentsToBreach: [], segmentsToChoose: segmentsToChoose, selection: { _ in })
    
    XCTAssertEqual(sut.segmentsToChoose[0].state, blackSegment.state)
    XCTAssertEqual(sut.segmentsToChoose[1].state, blueSegment.state)
    XCTAssertEqual(segmentsToChoose, sut.segmentsToChoose)
  }
  
  func test_hasSegmentsToBreach_setNewStateToOneSegment_changesState() {
    let blackSegment = makeColoredSegment(color: .black)
    let blueSegment = makeColoredSegment(color: .blue)
    let segmentsToBreach = [blackSegment, blueSegment]
    let sut = makeSUT(segmentsToBreach: segmentsToBreach, segmentsToChoose: [], selection: { _ in })
    
    sut.setState(.selected, for: blackSegment)
    
    XCTAssertEqual(sut.segmentsToBreach[0].state, .selected)
//    XCTAssertEqual(sut.segmentsToChooseCollectionView.cell(at:
  }
  
  //  MARK: - Helpers
  func makeSUT(
    segmentsToBreach: [ColoredSegment<ClassicColorProvider>] = [],
    segmentsToChoose: [ColoredSegment<ClassicColorProvider>] = [],
    selection: @escaping (ColoredSegment<ClassicColorProvider>) -> Void = { _ in }
  ) -> BreachViewController {
    let sut = BreachViewController(
      segmentsToBreach: segmentsToBreach,
      segmentsToChoose: segmentsToChoose,
      router: BreachRouter<ColoredSegment, BreachViewController>(),
      selection: selection
    )
    _ = sut.view
    return sut
  }
  
  func makeColoredSegment(
    color: UIColor,
    colorProvider: ClassicColorProvider = ClassicColorProvider()
  ) -> ColoredSegment<ClassicColorProvider> {
    ColoredSegment<ClassicColorProvider>(color, colorProvider: colorProvider)
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
