//
//  Created by Ilya Sakalou on 5/12/20.
//  Copyright © 2020 Nirma. All rights reserved.
//

import UIKit
import WY_Mini_Tool_Engine

enum BreachStatus: String {
  case noSegmentsToBreach
  case noSegmentsToSelect
  case breaching
}

final class BreachViewController: UIViewController {
  typealias Segment = ColoredSegment<ClassicColorProvider>
  @IBOutlet var segmentsToBreachStackView: UIStackView!
  @IBOutlet var segmentsToChooseCollectionView: UICollectionView!
  
  var status: BreachStatus = .noSegmentsToBreach
  var segmentsToBreach: [Segment] = []
  var segmentsToChoose: [Segment] = []
  private var selection: ((Segment) -> Void)?
  var router: BreachRouter<Segment, BreachViewController>?
  
  convenience init(
    segmentsToBreach: [Segment],
    segmentsToChoose: [Segment],
    router: BreachRouter<Segment, BreachViewController>,
    selection: @escaping (Segment) -> Void
  ) {
    self.init()
    self.selection = selection
    self.segmentsToBreach = segmentsToBreach
    self.segmentsToChoose = segmentsToChoose
    self.router = router
    self.router?.viewInput = self
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    segmentsToChooseCollectionView.register(SegmentViewCell.self)
    
    if !segmentsToBreach.isEmpty, !segmentsToChoose.isEmpty {
      status = .breaching
    } else if segmentsToChoose.isEmpty {
      status = .noSegmentsToSelect
    }
    
    if segmentsToBreach.isEmpty {
      status = .noSegmentsToBreach
    }
    
    setSegmentsToBreach(segmentsToBreach)
    segmentsToChooseCollectionView.reloadData()
  }
  
  private func setSegmentsToBreach(_ segments: [Segment]) {
    for segment in segments {
      if let cell = getColoredCellView() as? SegmentViewCell {
        cell.configure(with: segment)
        segmentsToBreachStackView.addArrangedSubview(cell)
      }
    }
  }
  
  private func getColoredCellView() -> UIView? {
    guard let view = UINib(
      nibName: "SegmentViewCell",
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
      let cell: SegmentViewCell = collectionView.dequeueCell(at: indexPath)
    else { return UICollectionViewCell() }
    
    let segment = segmentsToChoose[indexPath.row]
    cell.configure(with: segment)
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
  func setState(_ state: SegmentState, for segment: Segment) {
    guard let index = segmentsToBreach.firstIndex(of: segment) else { return }
    segmentsToBreach[index].setState(state)
    //let indexPath = IndexPath(row: index, section: 0)
    //segmentsToChooseCollectionView.reloadItems(at: [indexPath])
  }
  
  func finishFlow() {}
}
