//
//  Created by Ilya Sakalou on 5/3/20.
//  Copyright © 2020 Nirma. All rights reserved.
//

import UIKit
import WY_Mini_Tool_Engine

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  
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
    
    let selectionDataSource = DataSource<ColoredSegmentViewCellData, ColoredSegmentViewCell>()
    let breachingDataSource = DataSource<ColoredSegmentViewCellData, ColoredSegmentViewCell>()
    let presenter = BreachPresenter<
      ColoredSegment, ColoredSegmentViewCellData, ColoredSegmentViewCell
    >(
      segmentsToBreach: segmentsToBreach,
      segmentsToChoose: segmentsToChoose,
      collectionViewDataSource: selectionDataSource,
      breachViewDataSource: breachingDataSource
    )
    let router = BreachRouter<
      ColoredSegment,
      BreachPresenter<ColoredSegment, ColoredSegmentViewCellData, ColoredSegmentViewCell>
    >()
    
    let breachController = BreachViewController(
      segmentsToBreach: segmentsToBreach,
      segmentsToChoose: segmentsToChoose,
      output: presenter
    ) { segment in
      router.selectionCallback(segment, router.routedSegment!)
    }
    
    miniToolController.addChild(breachController)
    miniToolController.miniToolGameContainerView.addSubview(breachController.view)
    breachController.view.frame = miniToolController.miniToolGameContainerView.bounds
    miniToolController.didMove(toParent: breachController)
    
    let flow = Flow<ColoredSegment, BreachRouter>(
      segments: segmentsToBreach,
      segmentsToSelect: segmentsToChoose,
      router: router
    )
    flow.start()
    
    return true
  }
}
