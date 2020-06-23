//
//  Created by Ilya Sakalou on 6/20/20.
//  Copyright © 2020 Nirma. All rights reserved.
//

import UIKit
import WY_Mini_Tool_Engine

protocol ColorProvider {
  func color(for state: SegmentState) -> UIColor
}

struct ClassicColorProvider: ColorProvider {
  func color(for condition: SegmentState) -> UIColor {
    switch condition {
      case .failed: return .red
      case .none: return .clear
      case .passed: return .green
      case .selected: return .gray
    }
  }
}

struct TransluentColorProvider: ColorProvider {
  func color(for condition: SegmentState) -> UIColor {
    switch condition {
      case .failed: return uicolor(with: "#E76F51")
      case .none: return .clear
      case .passed: return uicolor(with: "#2a9d8f")
      case .selected: return uicolor(with: "#E9C46A")
    }
  }
}
