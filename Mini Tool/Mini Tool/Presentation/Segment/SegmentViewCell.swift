//
//  SegmentView.swift
//  Mini Tool
//
//  Created by Ilya Sakalou on 5/9/20.
//  Copyright © 2020 Nirma. All rights reserved.
//

import UIKit
import WY_Mini_Tool_Engine

final class SegmentViewCell: UICollectionViewCell {
  @IBOutlet var coloredPanelView: UIView!
  var color: UIColor?
  
  func configure(with segment: ColoredSegment<ClassicColorProvider>) {
    coloredPanelView.backgroundColor = segment.value
    color = segment.value
  }
}
