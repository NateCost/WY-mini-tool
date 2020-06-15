//
//  Created by Ilya Sakalou on 5/28/20.
//  Copyright © 2020 Nirma. All rights reserved.
//

import Foundation
import WY_Mini_Tool_Engine

final class BreachRouter<
  Segment,
  ViewInput: BreachViewInput
>: Router where ViewInput.Segment == Segment {
  typealias SelectionCallback = (Segment, Segment) -> Void
  weak var viewInput: ViewInput?
  var routedSegment: Segment?
  var selectionCallback: (Segment, Segment) -> Void = { _, _ in }
  
  func handleSegment(
    _ segment: Segment,
    selectionCallback: @escaping SelectionCallback
  ) {
    routedSegment = segment
    self.selectionCallback = selectionCallback
  }
  
  func segmentUpdated(_ segment: Segment) {
    viewInput?.didUpdateSegment(segment)
  }
  
  func finish() {
    viewInput?.finishFlow()
  }
}

protocol BreachViewInput: class {
  associatedtype Segment: Hashable, Valuable, Statable
  var segmentsToBreach: [Segment] { get }
  func didUpdateSegment(_ segment: Segment)
  func finishFlow()
}
