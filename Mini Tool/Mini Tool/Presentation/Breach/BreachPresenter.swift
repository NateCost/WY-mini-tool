//
//  Created by Ilya Sakalou on 6/23/20.
//  Copyright © 2020 Nirma. All rights reserved.
//

import UIKit

// MARK: - BreachRouterOuput
extension BreachPresenter: BreachRouterOuput {
  func didUpdateSegment(_ segment: Segment) {
    if segmentsToChoose.contains(segment), let row = segmentsToChoose.firstIndex(of: segment) {
      selectCollectionViewDataSource.update(Model.make(value: segment.value, stateColor: segment.color), at: row)
      #warning("reload collection view")
    } else if segmentsToBreach.contains(segment), let row = segmentsToBreach.firstIndex(of: segment){
      breachViewDataSource.update(Model.make(value: segment.value, stateColor: segment.color), at: row)
      #warning("reload collection view")
    }
  }
  
  func finishFlow() {
    view?.finishFlow()
  }
}
// MARK: - BreachViewOutput
extension BreachPresenter: BreachViewOutput {
  func didSelectSegment(at index: Int) {
    guard segmentsToChoose.count > index else { return }
    selectionCallback?(segmentsToChoose[index])
  }
}

final class BreachPresenter<
  Segment: SegmentProtocol,
  Model: SegmentModel,
  Cell: SegmentConfigurableCell
> where Cell.Model == Model, Segment.Value == Model.Value {
  weak var view: BreachViewInput?
  var segmentsToBreach: [Segment]
  var segmentsToChoose: [Segment]
  var selectCollectionViewDataSource: DataSource<Model, Cell>
  var breachViewDataSource: DataSource<Model, Cell>
  var selectionCallback: ((Segment) -> Void)?
  
  init(
    segmentsToBreach: [Segment],
    segmentsToChoose: [Segment],
    selectCollectionViewDataSource: DataSource<Model, Cell>,
    breachViewDataSource: DataSource<Model, Cell>,
    selectionCallback: @escaping (Segment) -> Void
  ) {
    self.segmentsToBreach = segmentsToBreach
    self.segmentsToChoose = segmentsToChoose
    self.selectCollectionViewDataSource = selectCollectionViewDataSource
    selectCollectionViewDataSource.items = segmentsToChoose.map { Model.make(value: $0.value, stateColor: $0.color) }
    self.breachViewDataSource = breachViewDataSource
    breachViewDataSource.items = segmentsToBreach.map { Model.make(value: $0.value, stateColor: $0.color) }
    self.selectionCallback = selectionCallback
  }
}
