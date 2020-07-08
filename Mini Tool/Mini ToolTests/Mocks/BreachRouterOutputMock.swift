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
  var segmentsToBreach: [Segment]
  var finished = false
  var updatedSegment: Segment?
  
  init(segmentsToBreach: [Segment]) {
    self.segmentsToBreach = segmentsToBreach
  }
  
  func finishFlow() { finished = true }
  func didUpdateSegment(_ segment: Segment) { updatedSegment = segment }
}
