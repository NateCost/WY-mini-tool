//
//  Created by Ilya Sakalou on 6/25/20.
//  Copyright © 2020 Nirma. All rights reserved.
//

import Foundation
import XCTest
import WY_Mini_Tool_Engine
@testable import Mini_Tool

final class BreachRouterOutputMock<
  Segment: SegmentProtocol,
  Model: SegmentModel,
  Cell: SegmentConfigurableCell
>: BreachRouterOuput where Cell.Model == Model, Segment.Value == Model.Value {
  var collectionViewDataSource: UICollectionViewDataSource { _collectionViewDataSource }
  var _collectionViewDataSource: DataSource<Model, Cell>
  var segmentsToBreach: [Segment]
  var finished = false
  var updatedSegment: Segment?
  
  init(segmentsToBreach: [Segment], dataSource: DataSource<Model, Cell>) {
    self.segmentsToBreach = segmentsToBreach
    _collectionViewDataSource = dataSource
  }
  
  func finishFlow() { finished = true }
  func didUpdateSegment(_ segment: Segment) { updatedSegment = segment }
}
