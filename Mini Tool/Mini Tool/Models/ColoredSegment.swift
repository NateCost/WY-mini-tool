//
//  Created by Ilya Sakalou on 5/12/20.
//  Copyright © 2020 Nirma. All rights reserved.
//

import UIKit
import WY_Mini_Tool_Engine

protocol Segment: Hashable, Valuable, Statable {}

protocol ColorHolder {
  var color: UIColor { get }
}

class ColoredSegment: SegmentViewCellModel {
  typealias Value = UIColor
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
