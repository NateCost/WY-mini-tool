//
//  BreachRouter.swift
//  Mini Tool
//
//  Created by Ilya Sakalou on 5/28/20.
//  Copyright © 2020 Nirma. All rights reserved.
//

import Foundation
import WY_Mini_Tool_Engine

final class BreachRouter: Router {
  typealias Segment = ColoredSegment
  private var viewInput: BreachViewInput?
  
  init(viewInput: BreachViewInput) {
    self.viewInput = viewInput
  }
  
  func handleSegment(
    _ segment: ColoredSegment,
    selectionCallback: @escaping SelectionCallback
  ) {
    
  }
  
  func updateSegment(_ segment: ColoredSegment, with state: SegmentState) {
    
  }
  
  func finish() {
    viewInput?.finishFlow()
  }
}

protocol BreachViewInput: class {
  func finishFlow()
}
