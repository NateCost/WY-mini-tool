//
//  AppDelegate.swift
//  Mini Tool
//
//  Created by Ilya Sakalou on 5/3/20.
//  Copyright © 2020 Nirma. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let window = UIWindow(frame: UIScreen.main.bounds)
    let viewController = BreachViewController(
      segmentsToBreach: [PixelMatrixSegment(value: ""), PixelMatrixSegment(value: "")],
      segmentsToChoose: [PixelMatrixSegment(value: "")]
    ) {
      print($0.value)
    }
    window.rootViewController = viewController
    self.window = window
    window.makeKeyAndVisible()
    
    return true
  }
}
