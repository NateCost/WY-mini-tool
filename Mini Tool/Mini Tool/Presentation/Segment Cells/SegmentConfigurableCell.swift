//
//  Created by Ilya Sakalou on 6/22/20.
//  Copyright © 2020 Nirma. All rights reserved.
//

import Foundation

protocol SegmentConfigurableCell {
  associatedtype Model
  func configure(with model: Model)
}
