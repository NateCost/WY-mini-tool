//
//  Created by Ilya Sakalou on 5/3/20.
//  Copyright © 2020 Nirma. All rights reserved.
//

import UIKit
import WY_Mini_Tool_Engine

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  typealias ColoredPresenter = BreachPresenter<
    ColoredSegment,
    ColoredSegmentViewCellData,
    ColoredSegmentViewCell
  >
  typealias ColoredDataSource = DataSource<ColoredSegmentViewCellData, ColoredSegmentViewCell>
  
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let window = UIWindow(frame: UIScreen.main.bounds)
    let colorProvider = TransluentColorProvider()
    let segmentFactory = ColoredSegmentFactory(colorProvider: colorProvider)
    
    let segmentsToBreach = [
      segmentFactory.makeSegment(value: .green),
      segmentFactory.makeSegment(value: .blue),
      segmentFactory.makeSegment(value: .red)
    ]
    let segmentsToChoose = [
      segmentFactory.makeSegment(value: .red),
      segmentFactory.makeSegment(value: .black),
      segmentFactory.makeSegment(value: .green),
      segmentFactory.makeSegment(value: .yellow),
      segmentFactory.makeSegment(value: .gray),
      segmentFactory.makeSegment(value: .blue),
      segmentFactory.makeSegment(value: .magenta)
    ]
    
    let miniToolController = MiniToolController()
    window.rootViewController = miniToolController
    self.window = window
    window.makeKeyAndVisible()
    
    let selectCollectionViewDataSource = ColoredDataSource()
    let breachViewDataSource = ColoredDataSource()
    let router = BreachRouter<ColoredSegment, ColoredPresenter>()
    let presenter = ColoredPresenter(
      segmentsToBreach: segmentsToBreach,
      segmentsToChoose: segmentsToChoose,
      selectCollectionViewDataSource: selectCollectionViewDataSource,
      breachViewDataSource: breachViewDataSource
    ) { [weak router] segment in
      guard let router = router, let routedSegment = router.routedSegment else { return }
      router.selectionCallback(segment, routedSegment)
    }
    router.output = presenter

    let breachInput = BreachInput(
      output: presenter,
      selectionViewDataSource: selectCollectionViewDataSource,
      breachViewDataSource: breachViewDataSource,
      cellType: ColoredSegmentViewCell.self
    )
    let breach = BreachComposer.compose(withInput: breachInput)

    presenter.view = breach.viewController
    
    miniToolController.addChild(breach.viewController)
    miniToolController.miniToolGameContainerView.addSubview(breach.viewController.view)
    breach.viewController.view.frame = miniToolController.miniToolGameContainerView.bounds
    miniToolController.didMove(toParent: breach.viewController)
    
    let flow = Flow<ColoredSegment, BreachRouter>(
      segments: segmentsToBreach,
      segmentsToSelect: segmentsToChoose,
      router: router
    )
    flow.start()
    
    return true
  }
}
