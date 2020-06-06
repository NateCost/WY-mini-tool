//
//  Created by Ilya Sakalou on 5/31/20.
//  Copyright © 2020 Nirma. All rights reserved.
//

import Foundation

final class BreachComposer {
  let viewController: BreachViewController
  
  class func compose(withInput input: BreachInput) -> BreachComposer {
    let viewController = BreachViewController(
      segmentsToBreach: input.segmentsToBreach,
      segmentsToChoose: input.segmentsToChoose,
      router: input.router,
      selection: { _ in }
    )
    
    return BreachComposer(viewController: viewController)
  }
  
  private init(viewController: BreachViewController) {
    self.viewController = viewController
  }
}

struct BreachInput {
  let router: BreachRouter<ColoredSegment<ClassicColorProvider>, BreachViewController>
  let segmentsToBreach: [ColoredSegment<ClassicColorProvider>]
  let segmentsToChoose: [ColoredSegment<ClassicColorProvider>]
}
