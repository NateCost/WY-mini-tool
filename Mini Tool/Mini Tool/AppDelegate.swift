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
  typealias StringPresenter = BreachPresenter<
    StringSegment,
    StringSegmentViewCellData,
    StringSegmentViewCell
  >
  typealias ColoredDataSource = DataSource<ColoredSegmentViewCellData, ColoredSegmentViewCell>
  typealias StringDataSource = DataSource<StringSegmentViewCellData, StringSegmentViewCell>
  
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let window = UIWindow(frame: UIScreen.main.bounds)
    let colorProvider = TransluentColorProvider()
    
    let (segmentsToBreach, segmentsToChoose) = getStringTestSegments(
      colorProvider: colorProvider
    )
//    let (segmentsToBreach, segmentsToChoose) = getColoredTestSegments(
//      colorProvider: colorProvider
//    )

    let miniToolController = MiniToolController()
    window.rootViewController = miniToolController
    self.window = window
    window.makeKeyAndVisible()
    
    let router = BreachRouter<StringSegment, StringPresenter>()
    let breach = getStringSegmentBreachComposer(
      router: router,
      segmentsToBreach: segmentsToBreach,
      segmentsToChoose: segmentsToChoose
    )
    
//    let router = BreachRouter<ColoredSegment, ColoredPresenter>()
//    let breach = getColoredSegmentBreachComposer(
//      router: router,
//      segmentsToBreach: segmentsToBreach,
//      segmentsToChoose: segmentsToChoose
//    )
    
    miniToolController.addChild(breach.viewController)
    miniToolController.miniToolGameContainerView.addSubview(breach.viewController.view)
    breach.viewController.view.frame = miniToolController.miniToolGameContainerView.bounds
    miniToolController.didMove(toParent: breach.viewController)
    
    let flow = Flow<StringSegment, BreachRouter>(
      segments: segmentsToBreach,
      segmentsToSelect: segmentsToChoose,
      router: router
    )
    
//    let flow = Flow<ColoredSegment, BreachRouter>(
//      segments: segmentsToBreach,
//      segmentsToSelect: segmentsToChoose,
//      router: router
//    )
    flow.start()
    
    return true
  }
  
  func getStringTestSegments(
    colorProvider: ColorProvider
  ) -> ([StringSegment], [StringSegment]) {
    let segmentFactory = StringSegmentFactory(colorProvider: colorProvider)
    let segmentsToBreach = [
      segmentFactory.makeSegment(value: "12"),
      segmentFactory.makeSegment(value: "14"),
      segmentFactory.makeSegment(value: "02"),
    ]
    let segmentsToChoose = [
      segmentFactory.makeSegment(value: "22"),
      segmentFactory.makeSegment(value: "55"),
      segmentFactory.makeSegment(value: "f1"),
      segmentFactory.makeSegment(value: "zz"),
      segmentFactory.makeSegment(value: "14"),
      segmentFactory.makeSegment(value: "a3"),
      segmentFactory.makeSegment(value: "12"),
      segmentFactory.makeSegment(value: "02"),
    ]
    return (segmentsToBreach, segmentsToChoose)
  }
  
  func getStringSegmentBreachComposer(
    router: BreachRouter<StringSegment, StringPresenter>,
    segmentsToBreach: [StringSegment],
    segmentsToChoose: [StringSegment]
  ) -> BreachComposer {
    let selectCollectionViewDataSource = StringDataSource()
    let breachViewDataSource = StringDataSource()
    let presenter = StringPresenter(
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
      cellType: StringSegmentViewCell.self
    )
    let breach = BreachComposer.compose(withInput: breachInput)
    presenter.view = breach.viewController
    
    return breach
  }
  
  func getColoredSegmentBreachComposer(
    router: BreachRouter<ColoredSegment, ColoredPresenter>,
    segmentsToBreach: [ColoredSegment],
    segmentsToChoose: [ColoredSegment]
  ) -> BreachComposer {
    let selectCollectionViewDataSource = ColoredDataSource()
    let breachViewDataSource = ColoredDataSource()
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
    
    return breach
  }
  
  func getColoredTestSegments(
    colorProvider: ColorProvider
  ) -> ([ColoredSegment], [ColoredSegment]) {
    let segmentFactory = ColoredSegmentFactory(colorProvider: colorProvider)
    let segmentsToBreach = [
      segmentFactory.makeSegment(value: .black),
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
    return (segmentsToBreach, segmentsToChoose)
  }
}
