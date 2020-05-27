//
//  PixelMatrixSegment.swift
//  Mini Tool
//
//  Created by Ilya Sakalou on 5/12/20.
//  Copyright © 2020 Nirma. All rights reserved.
//

import UIKit
import WY_Mini_Tool_Engine

class ColoredSegment: Hashable, Valuable, Statable {
  typealias Value = UIColor
  var state: SegmentState = .none
  var value: Value
  
  func setState(_ state: SegmentState) {
    self.state = state
  }
  
  init(_ value: Value) {
    self.value = value
  }
  
  static func == (lhs: ColoredSegment, rhs: ColoredSegment) -> Bool {
    lhs.value == rhs.value
  }
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(value)
  }
}
