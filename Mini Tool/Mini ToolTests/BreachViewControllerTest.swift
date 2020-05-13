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
      segmentsToChoose: [PixelMatrixSegment(value: "S")]
    )
    XCTAssertEqual(sut.segmentsToChooseCollectionView.numberOfItems(inSection: 0), 1)
    XCTAssertEqual(
      makeSUT(
        segmentsToChoose: []
      ).segmentsToChooseCollectionView.numberOfItems(inSection: 0), 0
    )
  }
  
  func makeSUT(
    segmentsToBreach: [Segment] = [],
    segmentsToChoose: [Segment] = []
  ) -> BreachViewController {
    let sut = BreachViewController(
      segmentsToBreach: segmentsToBreach,
      segmentsToChoose: segmentsToChoose
    )
    _ = sut.view
    return sut
  }
}
