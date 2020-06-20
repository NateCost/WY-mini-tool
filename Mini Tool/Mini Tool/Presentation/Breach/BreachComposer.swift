//
//  Created by Ilya Sakalou on 5/31/20.
//  Copyright © 2020 Nirma. All rights reserved.
//

import Foundation
import WY_Mini_Tool_Engine

final class ColoredBreachComposer<CProvider: ColorProvider> where CProvider.Condition == SegmentState {
  let viewController: BreachViewController<ColoredSegment<CProvider>>
  
  class func compose(withInput input: BreachInput<CProvider>) -> ColoredBreachComposer {
    let viewController = BreachViewController(
      segmentsToBreach: input.segmentsToBreach,
      segmentsToChoose: input.segmentsToChoose,
      router: input.router,
      selection: { _ in }
    )
    
    return ColoredBreachComposer(viewController: viewController)
  }
  
  private init(viewController: BreachViewController<ColoredSegment<CProvider>>) {
    self.viewController = viewController
  }
}

struct BreachInput<CProvider: ColorProvider> where CProvider.Condition == SegmentState {
  let router: BreachRouter<ColoredSegment<CProvider>, BreachViewController<ColoredSegment<CProvider>>>
  let segmentsToBreach: [ColoredSegment<CProvider>]
  let segmentsToChoose: [ColoredSegment<CProvider>]
}
