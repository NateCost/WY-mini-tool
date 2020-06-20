//
//  Created by Ilya Sakalou on 5/12/20.
//  Copyright © 2020 Nirma. All rights reserved.
//

import UIKit
import WY_Mini_Tool_Engine

class ColoredSegment<
  CProvider: ColorProvider
>: Hashable, Valuable, Statable, ColorHolder where CProvider.Condition == SegmentState {
  typealias Value = UIColor
  var state: SegmentState = .none
  var value: Value
  var colorProvider: CProvider
  var color: UIColor { colorProvider.color(for: state) }
  
  func setState(_ state: SegmentState) {
    self.state = state
  }
  
  init(_ value: Value, colorProvider: CProvider) {
    self.value = value
    self.colorProvider = colorProvider
  }
}

protocol ColorHolder {
  var color: UIColor { get }
}

protocol ColorProvider {
  associatedtype Condition
  func color(for condition: Condition) -> UIColor
}
