//
//  Created by Ilya Sakalou on 5/31/20.
//  Copyright © 2020 Nirma. All rights reserved.
//

import UIKit
import WY_Mini_Tool_Engine

final class BreachComposer {
  let viewController: BreachViewController
  
  class func compose(withInput input: BreachInput) -> BreachComposer {
    let viewController = BreachViewController(
      output: input.output,
      cellType: input.cellType,
      selectionDataSource: input.selectionViewDataSource,
      breachDataSource: input.breachViewDataSource
    )
    
    return BreachComposer(viewController: viewController)
  }
  
  private init(viewController: BreachViewController) {
    self.viewController = viewController
  }
}

struct BreachInput {
  let output: BreachViewOutput
  let selectionViewDataSource: UICollectionViewDataSource
  let breachViewDataSource: UICollectionViewDataSource
  let cellType: UICollectionViewCell.Type
}

protocol BreachViewOutput: class {
  func didSelectSegment(at index: Int)
}
