//
//  BreachRouter.swift
//  Mini Tool
//
//  Created by Ilya Sakalou on 5/28/20.
//  Copyright © 2020 Nirma. All rights reserved.
//

import Foundation
import WY_Mini_Tool_Engine

final class BreachRouter<ViewInput: BreachViewInput>: Router where ViewInput.Segment: ColoredSegment {
  typealias Segment = ColoredSegment
  private var viewInput: ViewInput?
  var routedSegment: Segment?
  var selectionCallback: (Segment, Segment) -> Void = { _, _ in }
  
  init(viewInput: ViewInput) {
    self.viewInput = viewInput
  }
  
  func handleSegment(
    _ segment: Segment,
    selectionCallback: @escaping SelectionCallback
  ) {
    routedSegment = segment
    self.selectionCallback = selectionCallback
  }
  
  func updateSegment(_ segment: Segment, with state: SegmentState) {
//    viewInput?.setState(state, for: segment)
  }
  
  func finish() {
    viewInput?.finishFlow()
  }
}

protocol BreachViewInput: class {
  associatedtype Segment: Hashable, Valuable, Statable
  func setState(_ state: SegmentState, for segment: Segment)
  func finishFlow()
}

final class ColoredBreachViewInput: BreachViewInput {
  typealias Segment = ColoredSegment
  
  func setState(_ state: SegmentState, for segment: Segment) {
    
  }
  
  func finishFlow() {
    
  }
}
