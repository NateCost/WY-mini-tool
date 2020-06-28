//
//  Created by Ilya Sakalou on 5/12/20.
//  Copyright © 2020 Nirma. All rights reserved.
//

import UIKit
import WY_Mini_Tool_Engine

protocol ColorHolder {
  var color: UIColor { get }
}

class ColoredSegment: SegmentProtocol, ColorHolder {
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

struct ColoredSegmentFactory {
  var colorProvider: ColorProvider
  
  func makeSegment(value: ColoredSegment.Value) -> ColoredSegment {
    ColoredSegment(value, colorProvider: colorProvider)
  }
}

struct ColoredSegmentModel: SegmentModel {
  let stateColor: UIColor
  let value: UIColor
  
  static func make(value: UIColor, stateColor: UIColor) -> ColoredSegmentModel {
    ColoredSegmentModel(stateColor: stateColor, value: value)
  }
}
