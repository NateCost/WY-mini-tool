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
  
  func test_viewDidLoad_with2SegmentsToBreach_segmentsToBreachStackHasProperColors() {
    let sut = makeSUT(
      segmentsToBreach: [
        makeColoredSegment(color: .black),
        makeColoredSegment(color: .brown)
      ]
    )
    XCTAssertEqual(getBreachSegment(sut: sut, at: 0)!.coloredPanelView.backgroundColor, .black)
    XCTAssertEqual(getBreachSegment(sut: sut, at: 1)!.coloredPanelView.backgroundColor, .brown)
  }
  
  func test_viewDidLoad_collectionViewLoadsSegments() {
    let sut = makeSUT(
      segmentsToBreach: [],
      segmentsToChoose: [
        makeColoredSegment(color: .black),
        makeColoredSegment(color: .brown)
      ]
    )
    let cell1 = sut.segmentsToChooseCollectionView.cell(at: 0) as! SegmentViewCell
    XCTAssertEqual(cell1.coloredPanelView.backgroundColor, .black)
    let cell2 = sut.segmentsToChooseCollectionView.cell(at: 1) as! SegmentViewCell
    XCTAssertEqual(cell2.coloredPanelView.backgroundColor, .brown)
  }
  
  func test_optionSelection_invokesSelectionClosure() {
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
  }
  
  func test_hasSegmentsToChoose_persistSameStates() {
    let blackSegment = makeColoredSegment(color: .black)
    blackSegment.setState(.passed)
    let blueSegment = makeColoredSegment(color: .blue)
    blackSegment.setState(.none)
    let segmentsToChoose = [blackSegment, blueSegment]
    
    let sut = makeSUT(segmentsToBreach: [], segmentsToChoose: segmentsToChoose, selection: { _ in })
    
    XCTAssertEqual(sut.segmentsToChoose[0], blackSegment)
    XCTAssertEqual(sut.segmentsToChoose[1], blueSegment)
    XCTAssertEqual(segmentsToChoose, sut.segmentsToChoose)
  }
  
  func test_hasSegmentsToBreach_setNewStateToOneSegment_changesState() {
    let colorProvider = ClassicColorProvider()
    let blackSegment = makeColoredSegment(color: .black, colorProvider: colorProvider)
    let blueSegment = makeColoredSegment(color: .blue)
    let segmentsToBreach = [blackSegment, blueSegment]
    let sut = makeSUT(segmentsToBreach: segmentsToBreach, segmentsToChoose: [], selection: { _ in })
    
    blackSegment.setState(.selected)
    
    XCTAssertEqual(sut.segmentsToBreach[0].state, .selected)
  }
  
  func test_hasSegmentsToBreach_setNewStateToOneSegment_changesBreachSegmentBackgroundColor() {
    let colorProvider = ClassicColorProvider()
    let blackSegment = makeColoredSegment(color: .black, colorProvider: colorProvider)
    let segmentsToBreach = [blackSegment]
    let sut = makeSUT(segmentsToBreach: segmentsToBreach, segmentsToChoose: [], selection: { _ in })
    
    blackSegment.setState(.selected)
    sut.didUpdateSegment(blackSegment)
    
    XCTAssertEqual(
      (sut.segmentsToBreachStackView.subviews[0] as! SegmentViewCell).backgroundColor,
      colorProvider.color(for: .selected)
    )
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
  
  func getBreachSegment(sut: BreachViewController, at index: Int) -> SegmentViewCell? {
    guard sut.segmentsToBreachStackView.subviews.count > index else { return nil }
    return sut.segmentsToBreachStackView.subviews[index] as? SegmentViewCell
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
