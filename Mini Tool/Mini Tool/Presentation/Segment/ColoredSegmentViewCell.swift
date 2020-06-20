//
//  Created by Ilya Sakalou on 5/9/20.
//  Copyright © 2020 Nirma. All rights reserved.
//

import UIKit
import WY_Mini_Tool_Engine

protocol SegmentViewCellModel: Hashable, Valuable, Statable, ColorHolder {}

final class ColoredSegmentViewCell<
  Model: SegmentViewCellModel
>: UICollectionViewCell where Model.Value == UIColor {
  @IBOutlet var coloredPanelView: UIView!
  
  func configure(with model: Model) {
    coloredPanelView.backgroundColor = model.value
    backgroundColor = model.color
  }
}
