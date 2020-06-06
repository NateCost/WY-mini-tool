//
//  Created by Ilya Sakalou on 5/12/20.
//  Copyright © 2020 Nirma. All rights reserved.
//

import UIKit
import WY_Mini_Tool_Engine

class ColoredSegment<
  CProvider: ColorProvider
>: Hashable, Valuable, Statable where CProvider.Condition == SegmentState {
  typealias Value = UIColor
  var state: SegmentState = .none
  var value: Value
  var colorProvider: CProvider
  
  func setState(_ state: SegmentState) {
    self.state = state
  }
  
  init(_ value: Value, colorProvider: CProvider) {
    self.value = value
    self.colorProvider = colorProvider
  }
  
  static func == (lhs: ColoredSegment, rhs: ColoredSegment) -> Bool {
    lhs.hashValue == rhs.hashValue
  }
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(value)
  }
}

protocol ColorProvider {
  associatedtype Condition
  func color(for condition: Condition) -> UIColor
}

struct ClassicColorProvider: ColorProvider {
  typealias Condition = SegmentState
  
  func color(for condition: Condition) -> UIColor {
    switch condition {
      case .failed: return .red
      case .none: return .clear
      case .passed: return .green
      case .selected: return .gray
    }
  }
}
