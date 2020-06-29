//
//  Created by Ilya Sakalou on 5/12/20.
//  Copyright © 2020 Nirma. All rights reserved.
//

import UIKit
import WY_Mini_Tool_Engine

final class BreachViewController: UIViewController {
  @IBOutlet var segmentsToBreachStackView: UIStackView!
  @IBOutlet var segmentsToChooseCollectionView: UICollectionView!
  
  typealias Segment = ColoredSegment
  var segmentsToBreach: [Segment] = []
  var segmentsToChoose: [Segment] = []
  private var selection: ((Segment) -> Void)?
  var output: BreachViewOutput?
  
  convenience init(
    segmentsToBreach: [Segment],
    segmentsToChoose: [Segment],
    output: BreachViewOutput,
    selection: @escaping (Segment) -> Void
  ) {
    self.init()
    self.selection = selection
    self.segmentsToBreach = segmentsToBreach
    self.segmentsToChoose = segmentsToChoose
    self.output = output
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    segmentsToChooseCollectionView.register(ColoredSegmentViewCell.self)
    
    setSegmentsToBreach(segmentsToBreach)
    segmentsToChooseCollectionView.reloadData()
    setupFlowLayout(cellsPerRow: 5)
  }
  
  private func setupFlowLayout(cellsPerRow: Int) {
    if let flowLayout = segmentsToChooseCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
      let horizontalSpacing = flowLayout.minimumInteritemSpacing
      let cellsAmountPerRow = max(0, cellsPerRow - 1)
      let collectionWidth = segmentsToChooseCollectionView.frame.width
      let intercellsTotalWidth = CGFloat(cellsAmountPerRow) * horizontalSpacing
      let cellWidth = (collectionWidth - intercellsTotalWidth) / CGFloat(cellsPerRow)
      flowLayout.itemSize = CGSize(width: cellWidth, height: cellWidth)
    }
  }
  
  private func setSegmentsToBreach(_ segments: [Segment]) {
    for segment in segments {
      if let cell = getCellView() as? ColoredSegmentViewCell {
        let model = ColoredSegmentViewCellData(value: segment.value, stateColor: segment.color)
        cell.configure(with: model)
        segmentsToBreachStackView.addArrangedSubview(cell)
      }
    }
  }
  
  private func updateSegmentToBreach(_ segments: [Segment]) {
    guard segments.count == segmentsToBreachStackView.subviews.count else { return }
    for (index, segment) in segments.enumerated() {
      if let cell = segmentsToBreachStackView.subviews[index] as? ColoredSegmentViewCell {
        let model = ColoredSegmentViewCellData(value: segment.value, stateColor: segment.color)
        cell.configure(with: model)
      }
    }
  }
  
  private func getCellView() -> UIView? {
    guard let view = UINib(
      nibName: "ColoredSegmentViewCell",
      bundle: nil
    ).instantiate(withOwner: self).first as? UICollectionViewCell else { return nil }
    view.contentView.pinToSuperviewEdges()
    return view
  }
}
// MARK: - UICollectionViewDataSource
extension BreachViewController: UICollectionViewDataSource {
  func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int { segmentsToChoose.count }
  
  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    guard
      let cell: ColoredSegmentViewCell = collectionView.dequeueCell(at: indexPath)
    else { return UICollectionViewCell() }
    
    let segment = segmentsToChoose[indexPath.row]
    let model = ColoredSegmentViewCellData(value: segment.value, stateColor: segment.color)
    cell.configure(with: model)
    return cell
  }
}
// MARK: - UICollectionViewDelegate
extension BreachViewController: UICollectionViewDelegate {
  func collectionView(
    _ collectionView: UICollectionView,
    didSelectItemAt indexPath: IndexPath
  ) {
    selection?(segmentsToChoose[indexPath.row])
  }
}
// MARK: - BreachViewInput
extension BreachViewController: BreachViewInput {
//  func didUpdateBreachSegment(_ segment: SegmentModel, at index: Int) {
//    updateSegmentToBreach(segmentsToBreach)
//  }
//
//  func didUpdateChooseSegment(_ segment: SegmentModel, at index: Int) {
//    segmentsToChooseCollectionView.reloadItems(at: [IndexPath(row: index, section: 0)])
//  }
  
//  func didUpdateSegment(_ segment: Segment) {
//    if segmentsToChoose.contains(segment), let row = segmentsToChoose.firstIndex(of: segment) {
//      segmentsToChooseCollectionView.reloadItems(at: [IndexPath(row: row, section: 0)])
//    } else if segmentsToBreach.contains(segment) {
//      updateSegmentToBreach(segmentsToBreach)
//    }
//  }
  
  func finishFlow() {
    segmentsToChooseCollectionView.isHidden = true
  }
}
