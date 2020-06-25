//
//  Created by Ilya Sakalou on 6/23/20.
//  Copyright © 2020 Nirma. All rights reserved.
//

import Foundation

extension BreachPresenter: BreachRouterOuput {
  func didUpdateSegment(_ segment: Segment) {
    
  }
  
  func finishFlow() {
    
  }
}

extension BreachPresenter: BreachViewOutput {}

final class BreachPresenter<Segment: SegmentProtocol> {
  weak var view: BreachViewInput?
  var segmentsToBreach: [Segment]
  
  init(segmentsToBreach: [Segment]) {
    self.segmentsToBreach = segmentsToBreach
  }
}
