//
//  Created by Ilya Sakalou on 6/23/20.
//  Copyright © 2020 Nirma. All rights reserved.
//

import Foundation
import XCTest
import WY_Mini_Tool_Engine
@testable import Mini_Tool

typealias ColoredPresenter = BreachPresenter<
  ColoredSegment,
  ColoredSegmentViewCellData,
  ColoredSegmentViewCell
>
typealias ColoredDataSource = DataSource<ColoredSegmentViewCellData, ColoredSegmentViewCell>

class BreachPresenterTest: XCTestCase {
  let segment1 = ColoredSegment(.black, colorProvider: TransluentColorProvider())
  let segment2 = ColoredSegment(.red, colorProvider: TransluentColorProvider())
  let viewInputMock = BreachViewInputMock()
  
  func test_instantiate_setSegmentsToBreach_storesSegments() {
    let sut = makeSUT(segmentsToBreach: [segment1, segment2], segmentsToChoose: [])
    XCTAssertEqual(sut.segmentsToBreach, [segment1, segment2])
  }
  
  func test_finishBreach_triggersViewInputFinish() {
    let sut = makeSUT(segmentsToBreach: [segment1, segment2], segmentsToChoose: [])
    sut.view = viewInputMock
    
    sut.finishFlow()
    
    XCTAssertTrue(viewInputMock.finished)
  }
  
  func test_didUpdateChooseSegment_sendsSegmentToViewDataSource() {
    let choose1 = ColoredSegment(.black, colorProvider: ClassicColorProvider())
    let choose2 = ColoredSegment(.green, colorProvider: ClassicColorProvider())
    let chooseSegmentsCellData = makeColoredCellsData(from: [choose1, choose2])
    let sut = makeSUT(
      segmentsToBreach: [segment1, segment2],
      segmentsToChoose: [choose1, choose2]
    )
    let dataSource = ColoredDataSource(items: chooseSegmentsCellData)
    sut.selectCollectionViewDataSource = dataSource
    choose2.setState(.failed)

    sut.didUpdateSegment(choose2)

    XCTAssertEqual(dataSource.items[1].stateColor, choose2.color)
    XCTAssertEqual(dataSource.items[0].stateColor, choose1.color)
  }
  
  func test_didUpdateBreachSegment_sendsSegmentToViewDataSource() {
    let choose1 = ColoredSegment(.black, colorProvider: ClassicColorProvider())
    let choose2 = ColoredSegment(.green, colorProvider: ClassicColorProvider())
    let chooseSegmentsCellData = makeColoredCellsData(from: [choose1, choose2])
    let sut = makeSUT(
      segmentsToBreach: [segment1, segment2],
      segmentsToChoose: [choose1, choose2]
    )
    let dataSource = ColoredDataSource(items: chooseSegmentsCellData)
    sut.breachViewDataSource = dataSource
    segment1.setState(.passed)
    segment2.setState(.selected)
    
    sut.didUpdateSegment(segment1)
    sut.didUpdateSegment(segment2)
    
    XCTAssertEqual(dataSource.items[1].stateColor, segment2.color)
    XCTAssertEqual(dataSource.items[0].stateColor, segment1.color)
  }
  
  func test_didSelectSegment_atUnappropriateIndex_doesNotExecutesSelectionACallback() {
    let choose1 = ColoredSegment(.black, colorProvider: ClassicColorProvider())
    let choose2 = ColoredSegment(.green, colorProvider: ClassicColorProvider())
    var segment: ColoredSegment?
    let sut = makeSUT(
      segmentsToBreach: [segment1, segment2],
      segmentsToChoose: [choose1, choose2]
    ) { segment = $0 }
    
    sut.didSelectSegment(at: 2)

    XCTAssertNil(segment)
  }
  
  func test_didSelectSegment_atAppropriateIndex_executesSelectionCallbackWithRightSegment() {
    let choose1 = ColoredSegment(.black, colorProvider: ClassicColorProvider())
    let choose2 = ColoredSegment(.green, colorProvider: ClassicColorProvider())
    var segment: ColoredSegment?
    let sut = makeSUT(
      segmentsToBreach: [segment1, segment2],
      segmentsToChoose: [choose1, choose2]
    ) { segment = $0 }
    
    sut.didSelectSegment(at: 1)
    
    XCTAssertEqual(segment, choose2)
  }
  
  func makeSUT(
    segmentsToBreach: [ColoredSegment],
    segmentsToChoose: [ColoredSegment],
    selectionCallback: @escaping (ColoredSegment) -> Void = { _ in }
  ) -> ColoredPresenter {
    ColoredPresenter(
      segmentsToBreach: segmentsToBreach,
      segmentsToChoose: segmentsToChoose,
      selectCollectionViewDataSource: ColoredDataSource(),
      breachViewDataSource: ColoredDataSource(),
      selectionCallback: selectionCallback
    )
  }
  
  func makeColoredCellsData(from segments: [ColoredSegment]) -> [ColoredSegmentViewCellData] {
    segments.map { ColoredSegmentViewCellData.make(value: $0.value, stateColor: $0.color) }
  }
}
