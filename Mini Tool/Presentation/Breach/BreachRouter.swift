//
//  Created by Ilya Sakalou on 5/28/20.
//  Copyright © 2020 Nirma. All rights reserved.
//

import UIKit
import WY_Mini_Tool_Engine

final class BreachRouter<
  Segment,
  Output: BreachRouterOuput
>: Router where Output.Segment == Segment {
  typealias SelectionCallback = (Segment, Segment) -> Void
  weak var output: Output?
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
    output?.didUpdateSegment(segment)
  }
  
  func finish() {
    output?.finishFlow()
  }
}

protocol BreachRouterOuput: class {
  associatedtype Segment: Hashable, Valuable, Statable
  func didUpdateSegment(_ segment: Segment)
  func finishFlow()
}

protocol BreachViewInput: class {
  func finishFlow()
  func reloadSelectionSegment(at indexPath: IndexPath)
  func reloadBreachSegment(at indexPath: IndexPath)
}
