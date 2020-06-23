//
//  Created by Ilya Sakalou on 6/23/20.
//  Copyright © 2020 Nirma. All rights reserved.
//

import Foundation

extension BreachPresenter: BreachViewOutput {}

final class BreachPresenter<ViewInput: BreachViewInput> {
  weak var view: ViewInput!
}
