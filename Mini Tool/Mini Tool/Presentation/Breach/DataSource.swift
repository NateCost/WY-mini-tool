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
  
  func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int { items.count }
  
  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    guard let cell: Cell = collectionView.dequeueCell(at: indexPath) else { return UICollectionViewCell() }
    guard items.count > indexPath.row else { return cell }
    cell.configure(with: items[indexPath.row])
    return cell
  }
}
