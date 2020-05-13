//
//  Mini_ToolTests.swift
//  Mini ToolTests
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
    let sut = makeSUT(segmentsToBreach: [PixelMatrixSegment(value: "S1")])
    XCTAssertEqual(sut.status, BreachStatus.noSegmentsToSelect)
  }
  
  func test_viewDidLoad_withSegmentsToBreachAndToChoose_updatesStatus() {
    let sut = makeSUT(
      segmentsToBreach: [PixelMatrixSegment(value: "S1")],
      segmentsToChoose: [PixelMatrixSegment(value: "S1")]
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
        PixelMatrixSegment(value: "S1"),
        PixelMatrixSegment(value: "S2")
      ]
    )
    XCTAssertEqual(sut.segmentsToBreachStackView.subviews.count, 2)
  }
  
  func test_viewDidLoad_collectionViewLoadsSegments() {
    let sut = makeSUT(
      segmentsToBreach: [],
      segmentsToChoose: [
        PixelMatrixSegment(value: "S"),
        PixelMatrixSegment(value: "Z")
      ]
    )
    XCTAssertEqual(sut.segmentsToChooseCollectionView.value(at: 0), "S")
    XCTAssertEqual(sut.segmentsToChooseCollectionView.value(at: 1), "Z")
  }
  
  func test_optionSelection_notifiesDelegate() {
    var selectedSegment: Segment?
    
    let sut = makeSUT(
      segmentsToBreach: [PixelMatrixSegment(value: "S")],
      segmentsToChoose: [
        PixelMatrixSegment(value: "S"),
        PixelMatrixSegment(value: "Z")
      ]
    ) {
      selectedSegment = $0
    }
    
    sut.segmentsToChooseCollectionView.delegate?.collectionView?(
      sut.segmentsToChooseCollectionView,
      didSelectItemAt: IndexPath(row: 0, section: 0)
    )
    
    XCTAssertEqual(selectedSegment?.value, PixelMatrixSegment(value: "S").value)
  }
  
  func makeSUT(
    segmentsToBreach: [Segment] = [],
    segmentsToChoose: [Segment] = [],
    selection: @escaping (Segment) -> Void = { _ in }
  ) -> BreachViewController {
    let sut = BreachViewController(
      segmentsToBreach: segmentsToBreach,
      segmentsToChoose: segmentsToChoose,
      selection: selection
    )
    _ = sut.view
    return sut
  }
}
// MARK: - UICollectionView
private extension UICollectionView {
  func cell(at row: Int) -> SegmentViewCell? {
    dataSource?.collectionView(
      self,
      cellForItemAt: IndexPath(row: row, section: 0)
    ) as? SegmentViewCell
  }
  
  func value(at row: Int) -> String? {
    cell(at: row)?.value
  }
}
