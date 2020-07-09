//
//  Created by Ilya Sakalou on 5/14/20.
//  Copyright © 2020 Nirma. All rights reserved.
//

import UIKit

extension UICollectionView {
  func register(_ type: UICollectionViewCell.Type) {
    let className = String(describing: type)
    register(
      UINib(nibName: className, bundle: nil),
      forCellWithReuseIdentifier: className
    )
  }
  
  func dequeueCell<T: UICollectionViewCell>(at indexPath: IndexPath) -> T? {
    dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T
  }
}

extension UICollectionViewCell {
  static var reuseIdentifier: String { String(describing: self) }
}
