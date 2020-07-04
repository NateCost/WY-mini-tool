//
//  Created by Ilya Sakalou on 5/31/20.
//  Copyright © 2020 Nirma. All rights reserved.
//

import Foundation
import WY_Mini_Tool_Engine

final class ColoredBreachComposer {
  let viewController: BreachViewController
  
  class func compose(withInput input: BreachInput) -> ColoredBreachComposer {
    let viewController = BreachViewController(
      segmentsToBreach: input.segmentsToBreach,
      segmentsToChoose: input.segmentsToChoose,
      output: input.output,
      selection: { _ in }
    )
    
    return ColoredBreachComposer(viewController: viewController)
  }
  
  private init(viewController: BreachViewController) {
    self.viewController = viewController
  }
}

struct BreachInput {
  let output: BreachViewOutput
  let segmentsToBreach: [ColoredSegment]
  let segmentsToChoose: [ColoredSegment]
}

protocol BreachViewOutput: class {
  func didSelectSegment(at index: Int)
}
