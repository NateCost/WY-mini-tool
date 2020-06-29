//
//  Created by Ilya Sakalou on 6/24/20.
//  Copyright © 2020 Nirma. All rights reserved.
//

import Foundation
import XCTest
import WY_Mini_Tool_Engine
@testable import Mini_Tool

class BreachViewInputMock: BreachViewInput {
  var finished = false
  
  func finishFlow() {
    finished = true
  }
}
