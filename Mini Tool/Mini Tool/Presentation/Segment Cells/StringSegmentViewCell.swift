//
//  Created by Ilya Sakalou on 6/22/20.
//  Copyright © 2020 Nirma. All rights reserved.
//

import UIKit
import WY_Mini_Tool_Engine

protocol StringSegmentViewCellModel {
  var value: String { get }
  var stateColor: UIColor { get }
}

struct StringSegmentViewCellData: StringSegmentViewCellModel {
  var value: String
  var stateColor: UIColor
}

final class StringSegmentViewCell: UICollectionViewCell, SegmentConfigurableCell {
  @IBOutlet var valueLabel: UILabel!
  
  func configure(with model: StringSegmentViewCellModel) {
    valueLabel.text = model.value
    backgroundColor = model.stateColor
  }
}