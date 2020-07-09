//
//  Created by Ilya Sakalou on 6/22/20.
//  Copyright © 2020 Nirma. All rights reserved.
//

import UIKit
import WY_Mini_Tool_Engine

protocol SegmentProtocol: Hashable, Valuable, Statable, ColorHolder {}
protocol SegmentModel {
  associatedtype Value
  static func make(value: Value, stateColor: UIColor) -> Self
}
