//
//  Created by Ilya Sakalou on 5/9/20.
//  Copyright © 2020 Nirma. All rights reserved.
//

import UIKit
import WY_Mini_Tool_Engine

struct ColoredSegmentViewCellData: SegmentModel {
  static func make(value: UIColor, stateColor: UIColor) -> ColoredSegmentViewCellData {
    ColoredSegmentViewCellData(value: value, stateColor: stateColor)
  }
  
  typealias Value = UIColor
  var value: Value
  var stateColor: UIColor
}

final class ColoredSegmentViewCell: UICollectionViewCell, SegmentConfigurableCell {
  @IBOutlet var coloredPanelView: UIView!
  
  func configure(with model: ColoredSegmentViewCellData) {
    coloredPanelView.backgroundColor = model.value
    backgroundColor = model.stateColor
  }
}
