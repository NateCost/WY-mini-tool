//
//  Mini_ToolTests.swift
//  Mini ToolTests
//
//  Created by Ilya Sakalou on 5/3/20.
//  Copyright © 2020 Nirma. All rights reserved.
//

import Foundation
import XCTest
@testable import Mini_Tool

class BreachViewContllerTest: XCTestCase {
  func test_viewDidLoad_noSegmentsToBreach_updatesStatus() {
    let sut = BreachViewController(segmentsToBreach: [], segmentsToChoose: [])
    
    _ = sut.view
    
    XCTAssertEqual(sut.status, BreachStatus.noSegmentsToBreach)
  }
  
  func test_viewDidLoad_noSegmentsToChoose_updatesStatus() {
    let segment = PixelMatrixSegment(value: "S1")
    let sut = BreachViewController(
      segmentsToBreach: [segment],
      segmentsToChoose: []
    )
    
    _ = sut.view
    
    XCTAssertEqual(sut.status, BreachStatus.noSegmentsToSelect)
  }
  
  func test_viewDidLoad_withSegmentsToBreachAndToChoose_updatesStatus() {
    let segment = PixelMatrixSegment(value: "S1")
    let sut = BreachViewController(
      segmentsToBreach: [segment],
      segmentsToChoose: [segment]
    )
    
    _ = sut.view
    
    XCTAssertEqual(sut.status, BreachStatus.breaching)
  }
  
  func test_viewDidLoad_withNoSegmentsToBreach_segmentsToBreachStackIsEmpty() {
    let sut = BreachViewController(
      segmentsToBreach: [],
      segmentsToChoose: []
    )
    
    _ = sut.view
    
    XCTAssertEqual(sut.segmentsToBreachStackView.subviews.count, 0)
  }
  
  func test_viewDidLoad_with2SegmentsToBreach_segmentsToBreachStackHas2Subviews() {
    let segment1 = PixelMatrixSegment(value: "S1")
    let segment2 = PixelMatrixSegment(value: "S2")
    let segmentsToBreach = [segment1, segment2]
    let sut = BreachViewController(
      segmentsToBreach: segmentsToBreach,
      segmentsToChoose: []
    )
    
    _ = sut.view
    
    XCTAssertEqual(sut.segmentsToBreachStackView.subviews.count, segmentsToBreach.count)
  }
  
  func test_viewDidLoad_withNoSegmentsToChoose_collectionViewIsEmpty() {
    let sut = BreachViewController(
      segmentsToBreach: [],
      segmentsToChoose: []
    )
    
    _ = sut.view
    
    XCTAssertEqual(sut.segmentsToChooseCollectionView.numberOfItems(inSection: 0), 0)
  }
  
  func test_viewDidLoad_withOneSegmentToChoose_collectionViewHasOneCell() {
    let segment = PixelMatrixSegment(value: "S")
    let sut = BreachViewController(
      segmentsToBreach: [],
      segmentsToChoose: [segment]
    )
    
    _ = sut.view
    
    XCTAssertEqual(sut.segmentsToChooseCollectionView.numberOfItems(inSection: 0), 1)
  }
}
