//
//  Created by Ilya Sakalou on 5/9/20.
//  Copyright © 2020 Nirma. All rights reserved.
//

import UIKit
import WY_Mini_Tool_Engine

protocol ColoredSegmentConfigurableCell {
  associatedtype Model
  func configure(with model: Model)
}

protocol ColoredSegmentViewCellModel {
  var value: UIColor { get }
  var stateColor: UIColor { get }
}

struct ColoredSegmentViewCellData: ColoredSegmentViewCellModel {
  var value: UIColor
  var stateColor: UIColor
}

final class ColoredSegmentViewCell: UICollectionViewCell, ColoredSegmentConfigurableCell {
  @IBOutlet var coloredPanelView: UIView!
  
  func configure(with model: ColoredSegmentViewCellModel) {
    coloredPanelView.backgroundColor = model.value
    backgroundColor = model.stateColor
  }
}
