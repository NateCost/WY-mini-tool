//
//  Created by Ilya Sakalou on 5/9/20.
//  Copyright © 2020 Nirma. All rights reserved.
//

import UIKit
import WY_Mini_Tool_Engine

protocol SegmentViewCellModel: Segment, ColorHolder {}

final class ColoredSegmentViewCell<
  Model: SegmentViewCellModel
>: UICollectionViewCell where Model.Value == UIColor {
  var coloredPanelView: UIView?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    coloredPanelView = UIView()
    addSubview(coloredPanelView!)
    coloredPanelView?.pinToSuperviewEdges(with: UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6))
  }
  
  func configure(with model: Model) {
    coloredPanelView?.backgroundColor = model.value
    backgroundColor = model.color
  }
}
