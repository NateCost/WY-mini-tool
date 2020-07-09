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
  var data: (
    selectionDataSource: UICollectionViewDataSource,
    breachDataSource: UICollectionViewDataSource,
    cellType: UICollectionViewCell.Type
  )?
  
  convenience init(
    output: BreachViewOutput,
    cellType: UICollectionViewCell.Type,
    selectionDataSource: UICollectionViewDataSource,
    breachDataSource: UICollectionViewDataSource
  ) {
    self.init()
    self.output = output
    data = (selectionDataSource, breachDataSource, cellType)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    guard let data = data else { return }
    selectionCollectionView.register(data.cellType)
    selectionCollectionView.delegate = self
    selectionCollectionView.dataSource = data.selectionDataSource
    breachCollectionView.register(data.cellType)
    breachCollectionView.dataSource = data.breachDataSource
    
    selectionCollectionView.reloadData()
    breachCollectionView.reloadData()
    let selectionItemsCount = selectionCollectionView.dataSource?.collectionView(
      selectionCollectionView, numberOfItemsInSection: 0
    ) ?? 0
    let breachItemsCount = breachCollectionView.dataSource?.collectionView(
      breachCollectionView, numberOfItemsInSection: 0
    ) ?? 0
    setupCollectionFlowLayout(
      collectionView: selectionCollectionView,
      cellsPerRow: min(selectionItemsCount, 4)
    )
    setupCollectionFlowLayout(
      collectionView: breachCollectionView,
      cellsPerRow: breachItemsCount
    )
  }
  
  private func setupCollectionFlowLayout(
    collectionView: UICollectionView,
    cellsPerRow: Int
  ) {
    guard let flowLayout = collectionView.collectionViewLayout
      as? UICollectionViewFlowLayout else { return }
    let horizontalSpacing = flowLayout.minimumInteritemSpacing
    let cellsAmountPerRow = max(0, cellsPerRow)
    let collectionWidth = collectionView.frame.width
    let intercellsTotalWidth = CGFloat(cellsAmountPerRow) * horizontalSpacing
    let cellWidth = (collectionWidth - intercellsTotalWidth) / CGFloat(cellsPerRow + 1)
    flowLayout.itemSize = CGSize(width: cellWidth, height: cellWidth)
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
