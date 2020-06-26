//
//  Created by Ilya Sakalou on 5/3/20.
//  Copyright © 2020 Nirma. All rights reserved.
//

import Foundation
import XCTest
import WY_Mini_Tool_Engine
@testable import Mini_Tool

class BreachViewControllerTest: XCTestCase {
  func test_instantiate_injectSegments_storesSegments() {
    let segmentsToBreach = [makeColoredSegment(color: .black), makeColoredSegment(color: .blue)]
    let segmentsToChoose = [
      makeColoredSegment(color: .black),
      makeColoredSegment(color: .red),
      makeColoredSegment(color: .yellow)
    ]
    let sut = makeSUT(segmentsToBreach: segmentsToBreach, segmentsToChoose: segmentsToChoose)
    
    XCTAssertEqual(sut.segmentsToChoose, segmentsToChoose)
    XCTAssertEqual(sut.segmentsToBreach, segmentsToBreach)
  }
  
  func test_viewDidLoad_with2SegmentsToBreach_segmentsToBreachStackHasProperColors() {
    let sut = makeSUT(
      segmentsToBreach: [
        makeColoredSegment(color: .black),
        makeColoredSegment(color: .brown)
      ]
    )
    XCTAssertEqual(getBreachSegment(sut: sut, at: 0)!.coloredPanelView!.backgroundColor, .black)
    XCTAssertEqual(getBreachSegment(sut: sut, at: 1)!.coloredPanelView!.backgroundColor, .brown)
  }
  
  func test_viewDidLoad_collectionViewLoadsSegments() {
    let sut = makeSUT(
      segmentsToBreach: [],
      segmentsToChoose: [
        makeColoredSegment(color: .black),
        makeColoredSegment(color: .brown)
      ]
    )
    let cell1 = sut.segmentsToChooseCollectionView.cell(at: 0) as! ColoredSegmentViewCell
    XCTAssertEqual(cell1.coloredPanelView!.backgroundColor, .black)
    let cell2 = sut.segmentsToChooseCollectionView.cell(at: 1) as! ColoredSegmentViewCell
    XCTAssertEqual(cell2.coloredPanelView!.backgroundColor, .brown)
  }
  
  func test_optionSelection_invokesSelectionClosure() {
    var selectedSegments: [ColoredSegment] = []
    
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
    let segmentIndex = 0
    let colorProvider = ClassicColorProvider()
    let blackSegment = makeColoredSegment(color: .black, colorProvider: colorProvider)
    let segmentsToBreach = [blackSegment]
    let sut = makeSUT(segmentsToBreach: segmentsToBreach, segmentsToChoose: [], selection: { _ in })
    
    blackSegment.setState(.selected)
    let blackSegmentModel = ColoredSegmentModel(stateColor: blackSegment.color, value: blackSegment.value)
    sut.didUpdateBreachSegment(blackSegmentModel, at: segmentIndex)
    
    XCTAssertEqual(
      (sut.segmentsToBreachStackView.subviews[segmentIndex] as! ColoredSegmentViewCell).backgroundColor,
      colorProvider.color(for: .selected)
    )
  }
  
  func test_hasSegmentsToChoose_updateSegmentState_changesSegmentBackgroundColor() {
    let segmentIndex = 0
    let colorProvider = ClassicColorProvider()
    let redSegment = makeColoredSegment(color: .red, colorProvider: colorProvider)
    let sut = makeSUT(
      segmentsToChoose: [redSegment],
      selection: { _ in }
    )
    let cell = sut.segmentsToChooseCollectionView.cell(at: segmentIndex) as! ColoredSegmentViewCell
    
    redSegment.setState(.failed)
    let segmentModel = ColoredSegmentModel(stateColor: redSegment.color, value: redSegment.value)
    sut.didUpdateChooseSegment(segmentModel, at: segmentIndex)
    #warning("add update")
    XCTAssertEqual(cell.backgroundColor, colorProvider.color(for: .failed))
  }
  
  //  MARK: - Helpers
  func makeSUT(
    segmentsToBreach: [ColoredSegment] = [],
    segmentsToChoose: [ColoredSegment] = [],
    selection: @escaping (ColoredSegment) -> Void = { _ in }
  ) -> BreachViewController {
    let presenter = BreachPresenter<ColoredSegment>(segmentsToBreach: segmentsToBreach)
    let sut = BreachViewController(
      segmentsToBreach: segmentsToBreach,
      segmentsToChoose: segmentsToChoose,
      output: presenter,
      selection: selection
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
  
  func getBreachSegment(sut: BreachViewController, at index: Int) -> ColoredSegmentViewCell? {
    guard sut.segmentsToBreachStackView.subviews.count > index else { return nil }
    return sut.segmentsToBreachStackView.subviews[index] as? ColoredSegmentViewCell
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
