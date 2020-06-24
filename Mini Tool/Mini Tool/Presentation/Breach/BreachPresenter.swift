//
//  Created by Ilya Sakalou on 6/23/20.
//  Copyright © 2020 Nirma. All rights reserved.
//

import Foundation

extension BreachPresenter: BreachViewOutput {}

extension BreachPresenter: BreachRouterOuput {
  func didUpdateSegment(_ segment: Segment) {}
  func finishFlow() {}
}

final class BreachPresenter<ViewInput: BreachViewInput, Segment: SegmentProtocol> {
  weak var view: ViewInput!
  var segmentsToBreach: [Segment]
  
  init(segmentsToBreach: [Segment]) {
    self.segmentsToBreach = segmentsToBreach
  }
}
