//
//  Created by Ilya Sakalou on 6/22/20.
//  Copyright © 2020 Nirma. All rights reserved.
//

import UIKit
import WY_Mini_Tool_Engine

class StringSegment: Segment, ColorHolder {
  typealias Value = String
  var state: SegmentState = .none
  var value: Value
  var colorProvider: ColorProvider
  var color: UIColor { colorProvider.color(for: state) }
  
  func setState(_ state: SegmentState) {
    self.state = state
  }
  
  init(_ value: Value, colorProvider: ColorProvider) {
    self.value = value
    self.colorProvider = colorProvider
  }
}

struct StringSegmentFactory {
  var colorProvider: ColorProvider
  
  func makeSegment(value: StringSegment.Value) -> StringSegment {
    StringSegment(value, colorProvider: colorProvider)
  }
}
