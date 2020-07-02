//
//  Created by Ilya Sakalou on 6/23/20.
//  Copyright © 2020 Nirma. All rights reserved.
//

import UIKit

extension BreachPresenter: BreachRouterOuput {
  func didUpdateSegment(_ segment: Segment) {
    if segmentsToChoose.contains(segment), let row = segmentsToChoose.firstIndex(of: segment) {
      _collectionViewDataSource.update(Model.make(value: segment.value, stateColor: segment.color), at: row)
    } else if segmentsToBreach.contains(segment) {
      //updateSegmentToBreach(segmentsToBreach)
    }
  }
  
  func finishFlow() {
    view?.finishFlow()
  }
}

extension BreachPresenter: BreachViewOutput {}

final class BreachPresenter<
  Segment: SegmentProtocol,
  Model: SegmentModel,
  Cell: SegmentConfigurableCell
> where Cell.Model == Model, Segment.Value == Model.Value {
  weak var view: BreachViewInput?
  var segmentsToBreach: [Segment]
  var segmentsToChoose: [Segment]
  var collectionViewDataSource: UICollectionViewDataSource { _collectionViewDataSource }
  var _collectionViewDataSource: DataSource<Model, Cell>
  
  init(
    segmentsToBreach: [Segment],
    segmentsToChoose: [Segment],
    collectionViewDataSource: DataSource<Model, Cell>
  ) {
    self.segmentsToBreach = segmentsToBreach
    self.segmentsToChoose = segmentsToChoose
    _collectionViewDataSource = collectionViewDataSource
    _collectionViewDataSource.items = segmentsToBreach.map { Model.make(value: $0.value, stateColor: $0.color) }
  }
}
