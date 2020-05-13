//
//  BreachViewController.swift
//  Mini Tool
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
  @IBOutlet var segmentsToBreachStackView: UIStackView!
  @IBOutlet var segmentsToChooseCollectionView: UICollectionView!
  
  var status: BreachStatus = .noSegmentsToBreach
  private var segmentsToBreach: [Segment] = []
  private var segmentsToChoose: [Segment] = []
  private let reuseIdentifier = "SegmentViewCell"
  
  convenience init(segmentsToBreach: [Segment], segmentsToChoose: [Segment]) {
    self.init()
    self.segmentsToBreach = segmentsToBreach
    self.segmentsToChoose = segmentsToChoose
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    segmentsToChooseCollectionView.register(
      SegmentViewCell.self,
      forCellWithReuseIdentifier: reuseIdentifier
    )
    
    if !segmentsToBreach.isEmpty && !segmentsToChoose.isEmpty {
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
    for _ in segments {
      segmentsToBreachStackView.addArrangedSubview(UIView())
    }
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
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: reuseIdentifier,
      for: indexPath
    ) as? SegmentViewCell else { return UICollectionViewCell() }
    
    let segment = segmentsToChoose[indexPath.row]
    cell.configure(with: segment)
    return cell
  }
}
