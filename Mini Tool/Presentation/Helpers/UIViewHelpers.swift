//
//  Created by Ilya Sakalou on 6/4/20.
//  Copyright © 2020 Nirma. All rights reserved.
//

import UIKit

extension UIView {
  func pinToSuperviewEdges(with inset: UIEdgeInsets = UIEdgeInsets.zero) {
    guard let superView = superview else {
      print("The view is not in the current view hierarchy")
      return
    }
    translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      topAnchor.constraint(equalTo: superView.topAnchor, constant: inset.top),
      bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -inset.bottom),
      leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: inset.left),
      trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: -inset.right)
    ])
  }
}
