//
//  Created by Ilya Sakalou on 5/12/20.
//  Copyright © 2020 Nirma. All rights reserved.
//

import UIKit
import WY_Mini_Tool_Engine

final class BreachViewController: UIViewController {
  @IBOutlet var selectionCollectionView: UICollectionView!
  @IBOutlet var breachCollectionView: UICollectionView!
  
  var output: BreachViewOutput?
  
  convenience init(
    output: BreachViewOutput
  ) {
    self.init()
    self.output = output
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    selectionCollectionView.register(ColoredSegmentViewCell.self)
    breachCollectionView.register(ColoredSegmentViewCell.self)
    
    selectionCollectionView.reloadData()
    breachCollectionView.reloadData()
    setupSelectionCollectionFlowLayout(cellsPerRow: 4)
  }
  
  private func setupSelectionCollectionFlowLayout(cellsPerRow: Int) {
    if let flowLayout = selectionCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
      let horizontalSpacing = flowLayout.minimumInteritemSpacing
      let cellsAmountPerRow = max(0, cellsPerRow)
      let collectionWidth = selectionCollectionView.frame.width
      let intercellsTotalWidth = CGFloat(cellsAmountPerRow) * horizontalSpacing
      let cellWidth = (collectionWidth - intercellsTotalWidth) / CGFloat(cellsPerRow + 1)
      flowLayout.itemSize = CGSize(width: cellWidth, height: cellWidth)
    }
  }
}
// MARK: - UICollectionViewDelegate
extension BreachViewController: UICollectionViewDelegate {
  func collectionView(
    _ collectionView: UICollectionView,
    didSelectItemAt indexPath: IndexPath
  ) {
    output?.didSelectSegment(at: indexPath.row)
  }
}
// MARK: - BreachViewInput
extension BreachViewController: BreachViewInput {
  func finishFlow() {
    selectionCollectionView.isHidden = true
  }
  
  func reloadSelectionSegment(at indexPath: IndexPath) {
    selectionCollectionView.reloadItems(at: [indexPath])
  }
  
  func reloadBreachSegment(at indexPath: IndexPath) {
    breachCollectionView.reloadItems(at: [indexPath])
  }
}
