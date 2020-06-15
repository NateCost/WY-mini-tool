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
    
    let segmentsToBreach = [
      ColoredSegment(.green, colorProvider: ClassicColorProvider()),
      ColoredSegment(.blue, colorProvider: ClassicColorProvider()),
      ColoredSegment(.red, colorProvider: ClassicColorProvider())
    ]
    let segmentsToChoose = [
      ColoredSegment(.red, colorProvider: ClassicColorProvider()),
      ColoredSegment(.black, colorProvider: ClassicColorProvider()),
      ColoredSegment(.green, colorProvider: ClassicColorProvider()),
      ColoredSegment(.yellow, colorProvider: ClassicColorProvider()),
      ColoredSegment(.gray, colorProvider: ClassicColorProvider()),
      ColoredSegment(.blue, colorProvider: ClassicColorProvider()),
      ColoredSegment(.magenta, colorProvider: ClassicColorProvider())
    ]
    
    let miniToolController = MiniToolController()
    window.rootViewController = miniToolController
    self.window = window
    window.makeKeyAndVisible()
    
    let router = BreachRouter<ColoredSegment, BreachViewController>()
    
    let breachController = BreachViewController(
      segmentsToBreach: segmentsToBreach,
      segmentsToChoose: segmentsToChoose,
      router: router
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
