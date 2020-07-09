//
//  Created by Ilya Sakalou on 6/22/20.
//  Copyright © 2020 Nirma. All rights reserved.
//

import UIKit
import WY_Mini_Tool_Engine

struct StringSegmentViewCellData: SegmentModel {
  typealias Value = String
  var value: Value
  var stateColor: UIColor
  
  static func make(value: Value, stateColor: UIColor) -> StringSegmentViewCellData {
    StringSegmentViewCellData(value: value, stateColor: stateColor)
  }
}

final class StringSegmentViewCell: UICollectionViewCell, SegmentConfigurableCell {
  @IBOutlet var valueLabel: UILabel!
  
  func configure(with model: StringSegmentViewCellData) {
    valueLabel.text = model.value
    backgroundColor = model.stateColor
  }
}
