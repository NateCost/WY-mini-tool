//
//  Created by Ilya Sakalou on 6/26/20.
//  Copyright © 2020 Nirma. All rights reserved.
//

import UIKit

final class DataSource<
  Model: SegmentModel,
  Cell: SegmentConfigurableCell
>: NSObject, UICollectionViewDataSource where Cell.Model == Model {
  var items: [Model] = []
  
  convenience init(items: [Model]) {
    self.init()
    self.items = items
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int { items.count }
  
  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    guard items.count > indexPath.row else { return UICollectionViewCell() }
    guard let cell: Cell = collectionView.dequeueCell(at: indexPath) else { return UICollectionViewCell() }
    cell.configure(with: items[indexPath.row])
    return cell
  }
}
