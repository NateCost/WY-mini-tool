//
//  Created by Ilya Sakalou on 6/24/20.
//  Copyright © 2020 Nirma. All rights reserved.
//

import Foundation
import XCTest
import WY_Mini_Tool_Engine
@testable import Mini_Tool

class BreachViewInputMock: BreachViewInput {
  typealias Segment = ColoredSegment
  var segmentsToBreach: [Segment]
  var finished = false
  var updatedSegment: Segment?
  
  init(segmentsToBreach: [Segment]) {
    self.segmentsToBreach = segmentsToBreach
  }
  
  func finishFlow() {
    finished = true
  }
  
  func didUpdateSegment(_ segment: Segment) {
    updatedSegment = segment
  }
}
