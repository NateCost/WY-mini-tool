//
//  Created by Ilya Sakalou on 6/23/20.
//  Copyright © 2020 Nirma. All rights reserved.
//

import UIKit

extension BreachPresenter: BreachRouterOuput {
  func didUpdateSegment(_ segment: Segment) {
    
  }
  
  func finishFlow() {
    
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
  var collectionViewDataSource: UICollectionViewDataSource { _collectionViewDataSource }
  var _collectionViewDataSource: DataSource<Model, Cell>
  
  init(segmentsToBreach: [Segment], collectionViewDataSource: DataSource<Model, Cell>) {
    self.segmentsToBreach = segmentsToBreach
    _collectionViewDataSource = collectionViewDataSource
    _collectionViewDataSource.items = segmentsToBreach.map { Model.make(value: $0.value, stateColor: $0.color) }
  }
}
